/* Automatically generated file; DO NOT EDIT */
/* Espressif IoT Development Framework Linker Script */
/* Generated from: /home/hws/miot_builder_mk/esp32-arduino-lib-builder/esp-idf/components/esp32/ld/esp32.project.ld.in */

/*  Default entry point:  */
ENTRY(call_start_cpu0);

SECTIONS
{
  /* RTC fast memory holds RTC wake stub code,
     including from any source file named rtc_wake_stub*.c
  */
  .rtc.text :
  {
    . = ALIGN(4);

    *( .rtc.literal  .rtc.text EXCLUDE_FILE(*libfreertos.a:port.* *libfreertos.a:tasks.*) .rtc.text.*)
    *libfreertos.a:port.*( .rtc.text.*)
    *libfreertos.a:tasks.*( .rtc.text.*)
    *libfreertos.a:port.*(.rtc.text.pxPortInitialiseStack)
    *libfreertos.a:port.*(.rtc.text.xPortStartScheduler)
    *libfreertos.a:tasks.*(.rtc.text.vTaskStartScheduler)

    *rtc_wake_stub*.*(.literal .text .literal.* .text.*)
    _rtc_text_end = ABSOLUTE(.);
  } > rtc_iram_seg

  /*
    This section is required to skip rtc.text area because rtc_iram_seg and
    rtc_data_seg are reflect the same address space on different buses.
  */
  .rtc.dummy :
  {
    _rtc_dummy_start = ABSOLUTE(.);
    _rtc_fast_start = ABSOLUTE(.);
    . = SIZEOF(.rtc.text);
    _rtc_dummy_end = ABSOLUTE(.);
  } > rtc_data_seg

  /* This section located in RTC FAST Memory area.
     It holds data marked with RTC_FAST_ATTR attribute.
     See the file "esp_attr.h" for more information.
  */
  .rtc.force_fast :
  {
    . = ALIGN(4);
    _rtc_force_fast_start = ABSOLUTE(.);
    *(.rtc.force_fast .rtc.force_fast.*)
    . = ALIGN(4) ;
    _rtc_force_fast_end = ABSOLUTE(.);
  } > rtc_data_seg

  /* RTC data section holds RTC wake stub
     data/rodata, including from any source file
     named rtc_wake_stub*.c and the data marked with
     RTC_DATA_ATTR, RTC_RODATA_ATTR attributes.
     The memory location of the data is dependent on
     CONFIG_ESP32_RTCDATA_IN_FAST_MEM option.
  */
  .rtc.data :
  {
    _rtc_data_start = ABSOLUTE(.);

    *( .rtc.data EXCLUDE_FILE(*libfreertos.a:port.* *libfreertos.a:tasks.*) .rtc.data.*  .rtc.rodata EXCLUDE_FILE(*libfreertos.a:port.* *libfreertos.a:tasks.*) .rtc.rodata.*)
    *libfreertos.a:port.*( .rtc.data.*  .rtc.rodata.*)
    *libfreertos.a:tasks.*( .rtc.data.*  .rtc.rodata.*)
    *libfreertos.a:port.*(.rtc.data.pxPortInitialiseStack .rtc.rodata.pxPortInitialiseStack)
    *libfreertos.a:port.*(.rtc.data.xPortStartScheduler .rtc.rodata.xPortStartScheduler)
    *libfreertos.a:tasks.*(.rtc.data.vTaskStartScheduler .rtc.rodata.vTaskStartScheduler)

    *rtc_wake_stub*.*(.data .rodata .data.* .rodata.* .bss .bss.*)
    _rtc_data_end = ABSOLUTE(.);
  } > rtc_data_location

  /* RTC bss, from any source file named rtc_wake_stub*.c */
  .rtc.bss (NOLOAD) :
  {
    _rtc_bss_start = ABSOLUTE(.);
    *rtc_wake_stub*.*(.bss .bss.*)
    *rtc_wake_stub*.*(COMMON)

    *( .rtc.bss)

    _rtc_bss_end = ABSOLUTE(.);
  } > rtc_data_location

  /* This section holds data that should not be initialized at power up
     and will be retained during deep sleep.
     User data marked with RTC_NOINIT_ATTR will be placed
     into this section. See the file "esp_attr.h" for more information.
	 The memory location of the data is dependent on
     CONFIG_ESP32_RTCDATA_IN_FAST_MEM option.
  */
  .rtc_noinit (NOLOAD):
  {
    . = ALIGN(4);
    _rtc_noinit_start = ABSOLUTE(.);
    *(.rtc_noinit .rtc_noinit.*)
    . = ALIGN(4) ;
    _rtc_noinit_end = ABSOLUTE(.);
  } > rtc_data_location

  /* This section located in RTC SLOW Memory area.
     It holds data marked with RTC_SLOW_ATTR attribute.
     See the file "esp_attr.h" for more information.
  */
  .rtc.force_slow :
  {
    . = ALIGN(4);
    _rtc_force_slow_start = ABSOLUTE(.);
    *(.rtc.force_slow .rtc.force_slow.*)
    . = ALIGN(4) ;
    _rtc_force_slow_end = ABSOLUTE(.);
  } > rtc_slow_seg

  /* Get size of rtc slow data based on rtc_data_location alias */
  _rtc_slow_length = (ORIGIN(rtc_slow_seg) == ORIGIN(rtc_data_location))
                        ? (_rtc_force_slow_end - _rtc_data_start)
                        : (_rtc_force_slow_end - _rtc_force_slow_start);

  _rtc_fast_length = (ORIGIN(rtc_slow_seg) == ORIGIN(rtc_data_location))
                        ? (_rtc_force_fast_end - _rtc_fast_start)
                        : (_rtc_noinit_end - _rtc_fast_start);

  ASSERT((_rtc_slow_length <= LENGTH(rtc_slow_seg)),
          "RTC_SLOW segment data does not fit.")

  ASSERT((_rtc_fast_length <= LENGTH(rtc_data_seg)),
          "RTC_FAST segment data does not fit.")

  /* Send .iram0 code to iram */
  .iram0.vectors :
  {
    _iram_start = ABSOLUTE(.);
    /* Vectors go to IRAM */
    _init_start = ABSOLUTE(.);
    /* Vectors according to builds/RF-2015.2-win32/esp108_v1_2_s5_512int_2/config.html */
    . = 0x0;
    KEEP(*(.WindowVectors.text));
    . = 0x180;
    KEEP(*(.Level2InterruptVector.text));
    . = 0x1c0;
    KEEP(*(.Level3InterruptVector.text));
    . = 0x200;
    KEEP(*(.Level4InterruptVector.text));
    . = 0x240;
    KEEP(*(.Level5InterruptVector.text));
    . = 0x280;
    KEEP(*(.DebugExceptionVector.text));
    . = 0x2c0;
    KEEP(*(.NMIExceptionVector.text));
    . = 0x300;
    KEEP(*(.KernelExceptionVector.text));
    . = 0x340;
    KEEP(*(.UserExceptionVector.text));
    . = 0x3C0;
    KEEP(*(.DoubleExceptionVector.text));
    . = 0x400;
    _invalid_pc_placeholder = ABSOLUTE(.);
    *(.*Vector.literal)

    *(.UserEnter.literal);
    *(.UserEnter.text);
    . = ALIGN (16);
    *(.entry.text)
    *(.init.literal)
    *(.init)
    _init_end = ABSOLUTE(.);
  } > iram0_0_seg

  .iram0.text :
  {
    /* Code marked as runnning out of IRAM */
    _iram_text_start = ABSOLUTE(.);

    *( .iram1 EXCLUDE_FILE(*libfreertos.a:port.* *libfreertos.a:tasks.*) .iram1.*)
    *libapp_trace.a:SEGGER_RTT_esp32.*( .literal  .literal.*  .text  .text.*)
    *libapp_trace.a:SEGGER_SYSVIEW.*( .literal  .literal.*  .text  .text.*)
    *libapp_trace.a:SEGGER_SYSVIEW_Config_FreeRTOS.*( .literal  .literal.*  .text  .text.*)
    *libapp_trace.a:SEGGER_SYSVIEW_FreeRTOS.*( .literal  .literal.*  .text  .text.*)
    *libapp_trace.a:app_trace.*( .literal  .literal.*  .text  .text.*)
    *libapp_trace.a:app_trace_util.*( .literal  .literal.*  .text  .text.*)
    *libdriver.a:gpio.*(.literal.gpio_iomux_in .text.gpio_iomux_in)
    *libdriver.a:gpio.*(.literal.gpio_iomux_out .text.gpio_iomux_out)
    *libesp32.a:panic.*( .literal  .literal.*  .text  .text.*)
    *libesp_event.a:default_event_loop.*(.literal.esp_event_isr_post .text.esp_event_isr_post)
    *libesp_event.a:esp_event.*(.literal.esp_event_isr_post_to .text.esp_event_isr_post_to)
    *libesp_gdbstub.a:( .literal  .literal.*  .text  .text.*)
    *libesp_ringbuf.a:( .literal  .literal.*  .text  .text.*)
    *libespcoredump.a:core_dump_common.*( .literal  .literal.*  .text  .text.*)
    *libespcoredump.a:core_dump_flash.*( .literal  .literal.*  .text  .text.*)
    *libespcoredump.a:core_dump_port.*( .literal  .literal.*  .text  .text.*)
    *libespcoredump.a:core_dump_uart.*( .literal  .literal.*  .text  .text.*)
    *libfreertos.a:( .literal EXCLUDE_FILE(*libfreertos.a:port.* *libfreertos.a:tasks.*) .literal.*  .text EXCLUDE_FILE(*libfreertos.a:port.* *libfreertos.a:tasks.*) .text.*)
    *libfreertos.a:port.*(.iram1.4.literal .iram1.4 .literal.xPortSysTickHandler .literal.vPortYieldOtherCore .literal.vPortReleaseTaskMPUSettings .literal.xPortInIsrContext .literal.vPortAssertIfInISR .literal.vPortCPUInitializeMutex .literal.vPortCPUAcquireMutex .literal.vPortCPUAcquireMutexTimeout .literal.vPortCPUReleaseMutex .literal.vPortSetStackWatchpoint .text.vPortEndScheduler .text.xPortSysTickHandler .text.vPortYieldOtherCore .text.vPortStoreTaskMPUSettings .text.vPortReleaseTaskMPUSettings .text.xPortInIsrContext .text.vPortAssertIfInISR .text.vPortCPUInitializeMutex .text.vPortCPUAcquireMutex .text.vPortCPUAcquireMutexTimeout .text.vPortCPUReleaseMutex .text.vPortSetStackWatchpoint .text.xPortGetTickRateHz)
    *libfreertos.a:tasks.*( .iram1.* .literal.prvInitialiseNewTask .literal.prvWriteNameToBuffer .literal.prvResetNextTaskUnblockTime .literal.prvDeleteTLS .literal.prvTaskIsTaskSuspended .literal.prvDeleteTCB .literal.prvAddCurrentTaskToDelayedList .literal.vTaskExitCritical$part$11 .literal.vTaskEnterCritical$constprop$14 .literal.vTaskExitCritical$constprop$15 .literal.prvIdleTask .literal.taskYIELD_OTHER_CORE .literal.prvAddNewTaskToReadyList$isra$12 .literal.xTaskCreateStaticPinnedToCore .literal.xTaskCreateRestricted .literal.xTaskCreatePinnedToCore .literal.vTaskResume .literal.xTaskResumeFromISR .literal.vTaskEndScheduler .literal.vTaskSuspendAll .literal.xTaskGetTickCount .literal.xTaskGetTickCountFromISR .literal.uxTaskGetNumberOfTasks .literal.uxTaskGetSystemState .literal.xTaskGetIdleTaskHandle .literal.xTaskGetIdleTaskHandleForCPU .literal.xTaskIncrementTick .literal.vTaskSwitchContext .literal.vTaskPlaceOnEventList .literal.vTaskPlaceOnUnorderedEventList .literal.vTaskPlaceOnEventListRestricted .literal.xTaskRemoveFromEventList .literal.xTaskRemoveFromUnorderedEventList .literal.vTaskSetTimeOutState .literal.xTaskCheckForTimeOut .literal.vTaskMissedYield .literal.vTaskAllocateMPURegions .literal.xTaskGetCurrentTaskHandle .literal.__getreent .literal.pcTaskGetTaskName .literal.pvTaskGetThreadLocalStoragePointer .literal.xTaskGetAffinity .literal.uxTaskGetStackHighWaterMark .literal.pxTaskGetStackStart .literal.eTaskGetState .literal.uxTaskPriorityGet .literal.uxTaskPriorityGetFromISR .literal.vTaskPrioritySet .literal.vTaskSetThreadLocalStoragePointerAndDelCallback .literal.vTaskSetThreadLocalStoragePointer .literal.xTaskGetCurrentTaskHandleForCPU .literal.xTaskGetSchedulerState .literal.vTaskDelete .literal.vTaskDelayUntil .literal.vTaskDelay .literal.xTaskResumeAll .literal.vTaskSuspend .literal.vTaskPriorityInherit .literal.xTaskPriorityDisinherit .literal.vTaskEnterCritical .literal.vTaskExitCritical .literal.vTaskList .literal.vTaskGetRunTimeStats .literal.uxTaskResetEventItemValue .literal.pvTaskIncrementMutexHeldCount .literal.ulTaskNotifyTake .literal.xTaskNotifyWait .literal.xTaskNotify .literal.xTaskNotifyFromISR .literal.vTaskNotifyGiveFromISR .literal.uxTaskGetSnapshotAll .text.prvInitialiseNewTask .text.prvWriteNameToBuffer .text.prvResetNextTaskUnblockTime .text.prvTaskGetSnapshotsFromList .text.prvDeleteTLS .text.prvTaskIsTaskSuspended .text.prvDeleteTCB .text.prvAddCurrentTaskToDelayedList .text.vTaskExitCritical$part$11 .text.vTaskEnterCritical$constprop$14 .text.vTaskExitCritical$constprop$15 .text.prvIdleTask .text.prvListTaskWithinSingleList .text.taskYIELD_OTHER_CORE .text.prvAddNewTaskToReadyList$isra$12 .text.xTaskCreateStaticPinnedToCore .text.xTaskCreateRestricted .text.xTaskCreatePinnedToCore .text.vTaskResume .text.xTaskResumeFromISR .text.vTaskEndScheduler .text.vTaskSuspendAll .text.xTaskGetTickCount .text.xTaskGetTickCountFromISR .text.uxTaskGetNumberOfTasks .text.uxTaskGetSystemState .text.xTaskGetIdleTaskHandle .text.xTaskGetIdleTaskHandleForCPU .text.xTaskIncrementTick .text.vTaskSwitchContext .text.vTaskPlaceOnEventList .text.vTaskPlaceOnUnorderedEventList .text.vTaskPlaceOnEventListRestricted .text.xTaskRemoveFromEventList .text.xTaskRemoveFromUnorderedEventList .text.vTaskSetTimeOutState .text.xTaskCheckForTimeOut .text.vTaskMissedYield .text.uxTaskGetTaskNumber .text.vTaskSetTaskNumber .text.vTaskAllocateMPURegions .text.xTaskGetCurrentTaskHandle .text.__getreent .text.pcTaskGetTaskName .text.pvTaskGetThreadLocalStoragePointer .text.xTaskGetAffinity .text.uxTaskGetStackHighWaterMark .text.pxTaskGetStackStart .text.eTaskGetState .text.uxTaskPriorityGet .text.uxTaskPriorityGetFromISR .text.vTaskPrioritySet .text.vTaskSetThreadLocalStoragePointerAndDelCallback .text.vTaskSetThreadLocalStoragePointer .text.xTaskGetCurrentTaskHandleForCPU .text.xTaskGetSchedulerState .text.vTaskDelete .text.vTaskDelayUntil .text.vTaskDelay .text.xTaskResumeAll .text.vTaskSuspend .text.vTaskPriorityInherit .text.xTaskPriorityDisinherit .text.vTaskEnterCritical .text.vTaskExitCritical .text.vTaskList .text.vTaskGetRunTimeStats .text.uxTaskResetEventItemValue .text.pvTaskIncrementMutexHeldCount .text.ulTaskNotifyTake .text.xTaskNotifyWait .text.xTaskNotify .text.xTaskNotifyFromISR .text.vTaskNotifyGiveFromISR .text.uxTaskGetSnapshotAll)
    *libfreertos.a:port.*(.iram1.pxPortInitialiseStack)
    *libfreertos.a:port.*(.iram1.xPortStartScheduler)
    *libfreertos.a:tasks.*(.iram1.vTaskStartScheduler)
    *libgcc.a:_divsf3.*( .literal  .literal.*  .text  .text.*)
    *libgcc.a:lib2funcs.*( .literal  .literal.*  .text  .text.*)
    *libgcov.a:( .literal  .literal.*  .text  .text.*)
    *libhal.a:( .literal  .literal.*  .text  .text.*)
    *libheap.a:multi_heap.*( .literal  .literal.*  .text  .text.*)
    *libheap.a:multi_heap_poisoning.*( .literal  .literal.*  .text  .text.*)
    *libnet80211.a:( .wifi0iram  .wifi0iram.*)
    *libnet80211.a:( .wifirxiram  .wifirxiram.*)
    *libnewlib.a:heap.*( .literal  .literal.*  .text  .text.*)
    *libpp.a:( .wifi0iram  .wifi0iram.*)
    *libpp.a:( .wifirxiram  .wifirxiram.*)
    *librtc.a:( .literal  .literal.*  .text  .text.*)
    *libsoc.a:cpu_util.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:lldesc.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:rtc_clk.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:rtc_clk_init.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:rtc_init.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:rtc_periph.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:rtc_pm.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:rtc_sleep.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:rtc_time.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:rtc_wdt.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:spi_flash_hal_iram.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:spi_hal_iram.*( .literal  .literal.*  .text  .text.*)
    *libsoc.a:spi_slave_hal_iram.*( .literal  .literal.*  .text  .text.*)
    *libspi_flash.a:esp_flash_api.*( .literal  .literal.*  .text  .text.*)
    *libspi_flash.a:esp_flash_spi_init.*( .literal  .literal.*  .text  .text.*)
    *libspi_flash.a:memspi_host_driver.*( .literal  .literal.*  .text  .text.*)
    *libspi_flash.a:spi_flash_chip_gd.*( .literal  .literal.*  .text  .text.*)
    *libspi_flash.a:spi_flash_chip_generic.*( .literal  .literal.*  .text  .text.*)
    *libspi_flash.a:spi_flash_chip_issi.*( .literal  .literal.*  .text  .text.*)
    *libspi_flash.a:spi_flash_rom_patch.*( .literal  .literal.*  .text  .text.*)
    *libxtensa.a:eri.*( .literal  .literal.*  .text  .text.*)

    _iram_text_end = ABSOLUTE(.);
    _iram_end = ABSOLUTE(.);
  } > iram0_0_seg

  ASSERT(((_iram_text_end - ORIGIN(iram0_0_seg)) <= LENGTH(iram0_0_seg)),
          "IRAM0 segment data does not fit.")

  .dram0.data :
  {
    _data_start = ABSOLUTE(.);
    _bt_data_start = ABSOLUTE(.);
    *libbt.a:(.data .data.*)
    . = ALIGN (4);
    _bt_data_end = ABSOLUTE(.);
    _btdm_data_start = ABSOLUTE(.);
    *libbtdm_app.a:(.data .data.*)
    . = ALIGN (4);
    _btdm_data_end = ABSOLUTE(.);
    _nimble_data_start = ABSOLUTE(.);
    *libnimble.a:(.data .data.*)
    . = ALIGN (4);
    _nimble_data_end = ABSOLUTE(.);
    *(.gnu.linkonce.d.*)
    *(.data1)
    *(.sdata)
    *(.sdata.*)
    *(.gnu.linkonce.s.*)
    *(.sdata2)
    *(.sdata2.*)
    *(.gnu.linkonce.s2.*)
    *(.jcr)

    *( .data EXCLUDE_FILE(*libfreertos.a:port.* *libfreertos.a:tasks.*) .data.*  .dram1 EXCLUDE_FILE(*libfreertos.a:port.* *libfreertos.a:tasks.*) .dram1.*)
    *libapp_trace.a:SEGGER_RTT_esp32.*( .rodata  .rodata.*)
    *libapp_trace.a:SEGGER_SYSVIEW.*( .rodata  .rodata.*)
    *libapp_trace.a:SEGGER_SYSVIEW_Config_FreeRTOS.*( .rodata  .rodata.*)
    *libapp_trace.a:SEGGER_SYSVIEW_FreeRTOS.*( .rodata  .rodata.*)
    *libapp_trace.a:app_trace.*( .rodata  .rodata.*)
    *libapp_trace.a:app_trace_util.*( .rodata  .rodata.*)
    *libdriver.a:gpio.*(.rodata.gpio_iomux_in)
    *libdriver.a:gpio.*(.rodata.gpio_iomux_out)
    *libesp32.a:panic.*( .rodata  .rodata.*)
    *libesp_event.a:default_event_loop.*(.rodata.esp_event_isr_post)
    *libesp_event.a:esp_event.*(.rodata.esp_event_isr_post_to)
    *libesp_gdbstub.a:( .rodata  .rodata.*)
    *libfreertos.a:port.*( .data.*  .dram1.*)
    *libfreertos.a:tasks.*(.data.xTaskQueueMutex .data.xNextTaskUnblockTime  .dram1.*)
    *libfreertos.a:port.*(.data.pxPortInitialiseStack .dram1.pxPortInitialiseStack)
    *libfreertos.a:port.*(.data.xPortStartScheduler .dram1.xPortStartScheduler)
    *libfreertos.a:tasks.*(.data.vTaskStartScheduler .dram1.vTaskStartScheduler)
    *libgcc.a:_divsf3.*( .rodata  .rodata.*)
    *libgcov.a:( .rodata  .rodata.*)
    *libheap.a:multi_heap.*( .rodata  .rodata.*)
    *libheap.a:multi_heap_poisoning.*( .rodata  .rodata.*)
    *libnewlib.a:heap.*( .rodata  .rodata.*)
    *libphy.a:( .rodata  .rodata.*)
    *libsoc.a:rtc_clk.*( .rodata  .rodata.*)
    *libsoc.a:spi_flash_hal_iram.*( .rodata  .rodata.*)
    *libspi_flash.a:memspi_host_driver.*( .rodata  .rodata.*)
    *libspi_flash.a:spi_flash_chip_gd.*( .rodata  .rodata.*)
    *libspi_flash.a:spi_flash_chip_generic.*( .rodata  .rodata.*)
    *libspi_flash.a:spi_flash_chip_issi.*( .rodata  .rodata.*)

    _data_end = ABSOLUTE(.);
    . = ALIGN(4);
  } > dram0_0_seg

  /* add function symble table by xiaomi */
  .miio_addon_list :
  {
    . = ALIGN(4);
    KEEP(*(SORT(.miio_addon_list*)));
    . = ALIGN(4);
  } > dram0_0_seg
  /* add function symble table by xiaomi end */

  /*This section holds data that should not be initialized at power up.
    The section located in Internal SRAM memory region. The macro _NOINIT
    can be used as attribute to place data into this section.
    See the esp_attr.h file for more information.
  */
  .noinit (NOLOAD):
  {
    . = ALIGN(4);
    _noinit_start = ABSOLUTE(.);
    *(.noinit .noinit.*)
    . = ALIGN(4) ;
    _noinit_end = ABSOLUTE(.);
  } > dram0_0_seg

  /* Shared RAM */
  .dram0.bss (NOLOAD) :
  {
    . = ALIGN (8);
    _bss_start = ABSOLUTE(.);
    *(.ext_ram.bss*)
    _bt_bss_start = ABSOLUTE(.);
    *libbt.a:(.bss .bss.* COMMON)
    . = ALIGN (4);
    _bt_bss_end = ABSOLUTE(.);
    _btdm_bss_start = ABSOLUTE(.);
    *libbtdm_app.a:(.bss .bss.* COMMON)
    . = ALIGN (4);
    _btdm_bss_end = ABSOLUTE(.);
    _nimble_bss_start = ABSOLUTE(.);
    *libnimble.a:(.bss .bss.* COMMON)
    . = ALIGN (4);
    _nimble_bss_end = ABSOLUTE(.);

    *( .bss EXCLUDE_FILE(*libfreertos.a:port.* *libfreertos.a:tasks.*) .bss.*  COMMON)
    *libfreertos.a:port.*(.bss.port_interruptNesting .bss.port_xSchedulerRunning)
    *libfreertos.a:tasks.*(.bss.xSwitchingContext .bss.ulTotalRunTime .bss.ulTaskSwitchedInTime .bss.uxSchedulerSuspended .bss.uxTaskNumber .bss.xNumOfOverflows .bss.xYieldPending .bss.uxPendedTicks .bss.xSchedulerRunning .bss.uxTopReadyPriority .bss.xTickCount .bss.uxCurrentNumberOfTasks .bss.xIdleTaskHandle .bss.xSuspendedTaskList .bss.uxTasksDeleted .bss.xTasksWaitingTermination .bss.xPendingReadyList .bss.pxOverflowDelayedTaskList .bss.pxDelayedTaskList .bss.xDelayedTaskList2 .bss.xDelayedTaskList1 .bss.pxReadyTasksLists .bss.pxCurrentTCB)
    *libfreertos.a:port.*(.bss.pxPortInitialiseStack)
    *libfreertos.a:port.*(.bss.xPortStartScheduler)
    *libfreertos.a:tasks.*(.bss.vTaskStartScheduler)

    *(.dynsbss)
    *(.sbss)
    *(.sbss.*)
    *(.gnu.linkonce.sb.*)
    *(.scommon)
    *(.sbss2)
    *(.sbss2.*)
    *(.gnu.linkonce.sb2.*)
    *(.dynbss)
    *(.share.mem)
    *(.gnu.linkonce.b.*)

    . = ALIGN (8);
    _bss_end = ABSOLUTE(.);
  } > dram0_0_seg

  ASSERT(((_bss_end - ORIGIN(dram0_0_seg)) <= LENGTH(dram0_0_seg)),
          "DRAM segment data does not fit.")

  .flash.rodata :
  {
    _rodata_start = ABSOLUTE(.);

    *(.rodata_desc .rodata_desc.*)               /* Should be the first.  App version info.        DO NOT PUT ANYTHING BEFORE IT! */
    *(.rodata_custom_desc .rodata_custom_desc.*) /* Should be the second. Custom app version info. DO NOT PUT ANYTHING BEFORE IT! */

    *(EXCLUDE_FILE(*libapp_trace.a:app_trace.* *libapp_trace.a:SEGGER_RTT_esp32.* *libapp_trace.a:SEGGER_SYSVIEW_Config_FreeRTOS.* *libapp_trace.a:SEGGER_SYSVIEW.* *libapp_trace.a:app_trace_util.* *libapp_trace.a:SEGGER_SYSVIEW_FreeRTOS.* *libesp32.a:panic.* *libgcc.a:_divsf3.* *libgcov.a *libesp_gdbstub.a *libphy.a *libspi_flash.a:spi_flash_chip_gd.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_issi.* *libheap.a:multi_heap.* *libheap.a:multi_heap_poisoning.* *libnewlib.a:heap.* *libsoc.a:spi_flash_hal_iram.* *libsoc.a:rtc_clk.*) .rodata EXCLUDE_FILE(*libapp_trace.a:app_trace.* *libapp_trace.a:SEGGER_RTT_esp32.* *libapp_trace.a:SEGGER_SYSVIEW_Config_FreeRTOS.* *libapp_trace.a:SEGGER_SYSVIEW.* *libapp_trace.a:app_trace_util.* *libapp_trace.a:SEGGER_SYSVIEW_FreeRTOS.* *libdriver.a:gpio.* *libesp32.a:panic.* *libgcc.a:_divsf3.* *libgcov.a *libesp_event.a:esp_event.* *libesp_event.a:default_event_loop.* *libesp_gdbstub.a *libphy.a *libspi_flash.a:spi_flash_chip_gd.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_issi.* *libfreertos.a:port.* *libfreertos.a:tasks.* *libheap.a:multi_heap.* *libheap.a:multi_heap_poisoning.* *libnewlib.a:heap.* *libsoc.a:spi_flash_hal_iram.* *libsoc.a:rtc_clk.*) .rodata.*)
    *libdriver.a:gpio.*(.rodata.gpio_output_disable.str1.1 .rodata.gpio_output_enable.str1.1 .rodata.gpio_set_intr_type.str1.1 .rodata.gpio_set_pull_mode.str1.1 .rodata.gpio_set_direction.str1.1 .rodata.gpio_config.str1.1 .rodata.gpio_reset_pin.str1.1 .rodata.gpio_isr_handler_add.str1.1 .rodata.gpio_isr_register.str1.1 .rodata.gpio_install_isr_service.str1.1 .rodata.gpio_wakeup_enable.str1.1 .rodata.gpio_set_drive_capability.str1.1 .rodata.gpio_get_drive_capability.str1.1 .rodata.gpio_hold_en.str1.1 .rodata.__FUNCTION__$5800 .rodata.__FUNCTION__$5795 .rodata.__FUNCTION__$5790 .rodata.__FUNCTION__$5785 .rodata.__FUNCTION__$5779 .rodata.__FUNCTION__$5774 .rodata.__FUNCTION__$5767 .rodata.__FUNCTION__$5752 .rodata.__FUNCTION__$5748 .rodata.__FUNCTION__$5744 .rodata.__func__$5723 .rodata.__FUNCTION__$5676 .rodata.__FUNCTION__$5680 .rodata.__FUNCTION__$5705 .rodata.__FUNCTION__$5693 .rodata.__FUNCTION__$5685 .rodata.__FUNCTION__$5672 .rodata.__FUNCTION__$5668 .rodata.__FUNCTION__$5657 .rodata.__FUNCTION__$5652 .rodata.__FUNCTION__$5648 .rodata.__FUNCTION__$5644 .rodata.__FUNCTION__$5640 .rodata.GPIO_HOLD_MASK)
    *libesp_event.a:default_event_loop.*(.rodata.esp_event_loop_create_default.str1.1 .rodata.esp_event_send_to_default_loop.str1.1 .rodata.esp_event_send_to_default_loop)
    *libesp_event.a:esp_event.*(.rodata.handler_instances_add$isra$2.str1.1 .rodata.base_node_add_handler.str1.1 .rodata.loop_node_add_handler.str1.1 .rodata.esp_event_loop_create.str1.1 .rodata.esp_event_loop_run.str1.1 .rodata.esp_event_loop_run_task.str1.1 .rodata.esp_event_handler_register_with.str1.1 .rodata.esp_event_handler_unregister_with.str1.1 .rodata.__func__$7132 .rodata.__func__$7119 .rodata.__func__$7099 .rodata.__func__$7083 .rodata.__func__$7060 .rodata.__func__$7019 .rodata.__func__$7010)
    *libfreertos.a:port.*(.rodata.vPortAssertIfInISR.str1.1 .rodata.__FUNCTION__$4845)
    *libfreertos.a:tasks.*(.rodata.prvDeleteTLS.str1.1 .rodata.vTaskStartScheduler.str1.1 .rodata.vTaskAllocateMPURegions.str1.1 .rodata.vTaskList.str1.1 .rodata.vTaskGetRunTimeStats.str1.1 .rodata.CSWTCH$125 .rodata.__FUNCTION__$5560 .rodata.__FUNCTION__$5547 .rodata.__FUNCTION__$5531 .rodata.__FUNCTION__$5439 .rodata.__FUNCTION__$5337 .rodata.__FUNCTION__$5292 .rodata.__FUNCTION__$5286 .rodata.__FUNCTION__$5282 .rodata.__FUNCTION__$5272 .rodata.__FUNCTION__$5263 .rodata.__FUNCTION__$5257 .rodata.__FUNCTION__$5250 .rodata.ucExpectedStackBytes$5222 .rodata.__FUNCTION__$5214 .rodata.__FUNCTION__$5205 .rodata.__FUNCTION__$5200 .rodata.__FUNCTION__$5187 .rodata.__FUNCTION__$5167 .rodata.__FUNCTION__$5149 .rodata.__FUNCTION__$5137 .rodata.__FUNCTION__$5126 .rodata.__FUNCTION__$5131 .rodata.__FUNCTION__$5120 .rodata.__FUNCTION__$5114 .rodata.__FUNCTION__$5095 .rodata.__FUNCTION__$5086 .rodata.__FUNCTION__$5079 .rodata.__FUNCTION__$5403 .rodata.__FUNCTION__$5407 .rodata.__FUNCTION__$5071 .rodata.__FUNCTION__$5022 .rodata.__FUNCTION__$5064 .rodata.__FUNCTION__$5015)
    *libfreertos.a:port.*(.rodata.pxPortInitialiseStack)
    *libfreertos.a:port.*(.rodata.xPortStartScheduler)
    *libfreertos.a:tasks.*(.rodata.vTaskStartScheduler)

    *(.irom1.text) /* catch stray ICACHE_RODATA_ATTR */
    *(.gnu.linkonce.r.*)
    *(.rodata1)
    __XT_EXCEPTION_TABLE_ = ABSOLUTE(.);
    *(.xt_except_table)
    *(.gcc_except_table .gcc_except_table.*)
    *(.gnu.linkonce.e.*)
    *(.gnu.version_r)
    . = (. + 3) & ~ 3;
    __eh_frame = ABSOLUTE(.);
    KEEP(*(.eh_frame))
    . = (. + 7) & ~ 3;
    /*  C++ constructor and destructor tables

        Make a point of not including anything from crtbegin.o or crtend.o, as IDF doesn't use toolchain crt
      */
    __init_array_start = ABSOLUTE(.);
    KEEP (*(EXCLUDE_FILE (*crtend.* *crtbegin.*) .ctors SORT(.ctors.*)))
    __init_array_end = ABSOLUTE(.);
    KEEP (*crtbegin.*(.dtors))
    KEEP (*(EXCLUDE_FILE (*crtend.*) .dtors))
    KEEP (*(SORT(.dtors.*)))
    KEEP (*(.dtors))
    /*  C++ exception handlers table:  */
    __XT_EXCEPTION_DESCS_ = ABSOLUTE(.);
    *(.xt_except_desc)
    *(.gnu.linkonce.h.*)
    __XT_EXCEPTION_DESCS_END__ = ABSOLUTE(.);
    *(.xt_except_desc_end)
    *(.dynamic)
    *(.gnu.version_d)
    /* Addresses of memory regions reserved via
       SOC_RESERVE_MEMORY_REGION() */
    soc_reserved_memory_region_start = ABSOLUTE(.);
    KEEP (*(.reserved_memory_address))
    soc_reserved_memory_region_end = ABSOLUTE(.);
    _rodata_end = ABSOLUTE(.);
    /* Literals are also RO data. */
    _lit4_start = ABSOLUTE(.);
    *(*.lit4)
    *(.lit4.*)
    *(.gnu.linkonce.lit4.*)
    _lit4_end = ABSOLUTE(.);
    . = ALIGN(4);
    _thread_local_start = ABSOLUTE(.);
    *(.tdata)
    *(.tdata.*)
    *(.tbss)
    *(.tbss.*)
    _thread_local_end = ABSOLUTE(.);
    . = ALIGN(4);
  } >drom0_0_seg

  .flash.text :
  {
    _stext = .;
    _text_start = ABSOLUTE(.);

    *(EXCLUDE_FILE(*libapp_trace.a:app_trace.* *libapp_trace.a:SEGGER_RTT_esp32.* *libapp_trace.a:SEGGER_SYSVIEW_Config_FreeRTOS.* *libapp_trace.a:SEGGER_SYSVIEW.* *libapp_trace.a:app_trace_util.* *libapp_trace.a:SEGGER_SYSVIEW_FreeRTOS.* *libesp32.a:panic.* *libgcc.a:_divsf3.* *libgcc.a:lib2funcs.* *libgcov.a *libesp_gdbstub.a *libesp_ringbuf.a *librtc.a *libespcoredump.a:core_dump_port.* *libespcoredump.a:core_dump_flash.* *libespcoredump.a:core_dump_common.* *libespcoredump.a:core_dump_uart.* *libspi_flash.a:spi_flash_chip_gd.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_rom_patch.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:esp_flash_spi_init.* *libspi_flash.a:esp_flash_api.* *libfreertos.a *libheap.a:multi_heap.* *libheap.a:multi_heap_poisoning.* *libnewlib.a:heap.* *libsoc.a:rtc_clk_init.* *libsoc.a:spi_flash_hal_iram.* *libsoc.a:rtc_time.* *libsoc.a:rtc_periph.* *libsoc.a:spi_hal_iram.* *libsoc.a:cpu_util.* *libsoc.a:rtc_wdt.* *libsoc.a:rtc_sleep.* *libsoc.a:rtc_clk.* *libsoc.a:rtc_init.* *libsoc.a:spi_slave_hal_iram.* *libsoc.a:rtc_pm.* *libsoc.a:lldesc.* *libxtensa.a:eri.* *libhal.a) .literal EXCLUDE_FILE(*libapp_trace.a:app_trace.* *libapp_trace.a:SEGGER_RTT_esp32.* *libapp_trace.a:SEGGER_SYSVIEW_Config_FreeRTOS.* *libapp_trace.a:SEGGER_SYSVIEW.* *libapp_trace.a:app_trace_util.* *libapp_trace.a:SEGGER_SYSVIEW_FreeRTOS.* *libdriver.a:gpio.* *libesp32.a:panic.* *libgcc.a:_divsf3.* *libgcc.a:lib2funcs.* *libgcov.a *libesp_event.a:esp_event.* *libesp_event.a:default_event_loop.* *libesp_gdbstub.a *libesp_ringbuf.a *librtc.a *libespcoredump.a:core_dump_port.* *libespcoredump.a:core_dump_flash.* *libespcoredump.a:core_dump_common.* *libespcoredump.a:core_dump_uart.* *libspi_flash.a:spi_flash_chip_gd.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_rom_patch.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:esp_flash_spi_init.* *libspi_flash.a:esp_flash_api.* *libfreertos.a:port.* *libfreertos.a:tasks.* *libfreertos.a *libheap.a:multi_heap.* *libheap.a:multi_heap_poisoning.* *libnewlib.a:heap.* *libsoc.a:rtc_clk_init.* *libsoc.a:spi_flash_hal_iram.* *libsoc.a:rtc_time.* *libsoc.a:rtc_periph.* *libsoc.a:spi_hal_iram.* *libsoc.a:cpu_util.* *libsoc.a:rtc_wdt.* *libsoc.a:rtc_sleep.* *libsoc.a:rtc_clk.* *libsoc.a:rtc_init.* *libsoc.a:spi_slave_hal_iram.* *libsoc.a:rtc_pm.* *libsoc.a:lldesc.* *libxtensa.a:eri.* *libhal.a) .literal.*  .phyiram EXCLUDE_FILE(*libfreertos.a:port.* *libfreertos.a:tasks.*) .phyiram.* EXCLUDE_FILE(*libapp_trace.a:app_trace.* *libapp_trace.a:SEGGER_RTT_esp32.* *libapp_trace.a:SEGGER_SYSVIEW_Config_FreeRTOS.* *libapp_trace.a:SEGGER_SYSVIEW.* *libapp_trace.a:app_trace_util.* *libapp_trace.a:SEGGER_SYSVIEW_FreeRTOS.* *libesp32.a:panic.* *libgcc.a:_divsf3.* *libgcc.a:lib2funcs.* *libgcov.a *libesp_gdbstub.a *libesp_ringbuf.a *librtc.a *libespcoredump.a:core_dump_port.* *libespcoredump.a:core_dump_flash.* *libespcoredump.a:core_dump_common.* *libespcoredump.a:core_dump_uart.* *libspi_flash.a:spi_flash_chip_gd.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_rom_patch.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:esp_flash_spi_init.* *libspi_flash.a:esp_flash_api.* *libfreertos.a *libheap.a:multi_heap.* *libheap.a:multi_heap_poisoning.* *libnewlib.a:heap.* *libsoc.a:rtc_clk_init.* *libsoc.a:spi_flash_hal_iram.* *libsoc.a:rtc_time.* *libsoc.a:rtc_periph.* *libsoc.a:spi_hal_iram.* *libsoc.a:cpu_util.* *libsoc.a:rtc_wdt.* *libsoc.a:rtc_sleep.* *libsoc.a:rtc_clk.* *libsoc.a:rtc_init.* *libsoc.a:spi_slave_hal_iram.* *libsoc.a:rtc_pm.* *libsoc.a:lldesc.* *libxtensa.a:eri.* *libhal.a) .text EXCLUDE_FILE(*libapp_trace.a:app_trace.* *libapp_trace.a:SEGGER_RTT_esp32.* *libapp_trace.a:SEGGER_SYSVIEW_Config_FreeRTOS.* *libapp_trace.a:SEGGER_SYSVIEW.* *libapp_trace.a:app_trace_util.* *libapp_trace.a:SEGGER_SYSVIEW_FreeRTOS.* *libdriver.a:gpio.* *libesp32.a:panic.* *libgcc.a:_divsf3.* *libgcc.a:lib2funcs.* *libgcov.a *libesp_event.a:esp_event.* *libesp_event.a:default_event_loop.* *libesp_gdbstub.a *libesp_ringbuf.a *librtc.a *libespcoredump.a:core_dump_port.* *libespcoredump.a:core_dump_flash.* *libespcoredump.a:core_dump_common.* *libespcoredump.a:core_dump_uart.* *libspi_flash.a:spi_flash_chip_gd.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_rom_patch.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:esp_flash_spi_init.* *libspi_flash.a:esp_flash_api.* *libfreertos.a:port.* *libfreertos.a:tasks.* *libfreertos.a *libheap.a:multi_heap.* *libheap.a:multi_heap_poisoning.* *libnewlib.a:heap.* *libsoc.a:rtc_clk_init.* *libsoc.a:spi_flash_hal_iram.* *libsoc.a:rtc_time.* *libsoc.a:rtc_periph.* *libsoc.a:spi_hal_iram.* *libsoc.a:cpu_util.* *libsoc.a:rtc_wdt.* *libsoc.a:rtc_sleep.* *libsoc.a:rtc_clk.* *libsoc.a:rtc_init.* *libsoc.a:spi_slave_hal_iram.* *libsoc.a:rtc_pm.* *libsoc.a:lldesc.* *libxtensa.a:eri.* *libhal.a) .text.* EXCLUDE_FILE(*libpp.a *libnet80211.a) .wifi0iram EXCLUDE_FILE(*libpp.a *libnet80211.a *libfreertos.a:port.* *libfreertos.a:tasks.*) .wifi0iram.* EXCLUDE_FILE(*libpp.a *libnet80211.a) .wifirxiram EXCLUDE_FILE(*libpp.a *libnet80211.a *libfreertos.a:port.* *libfreertos.a:tasks.*) .wifirxiram.*)
    *libdriver.a:gpio.*(.literal.rtc_gpio_is_valid_gpio .literal.gpio_output_disable .literal.gpio_output_enable .literal.gpio_intr_enable_on_core .literal.gpio_pullup_en .literal.gpio_pullup_dis .literal.gpio_pulldown_en .literal.gpio_pulldown_dis .literal.gpio_set_intr_type .literal.gpio_intr_enable .literal.gpio_intr_disable .literal.gpio_set_level .literal.gpio_get_level .literal.gpio_set_pull_mode .literal.gpio_set_direction .literal.gpio_config .literal.gpio_reset_pin .literal.gpio_isr_handler_add .literal.gpio_isr_handler_remove .literal.gpio_uninstall_isr_service .literal.gpio_isr_register .literal.gpio_install_isr_service .literal.gpio_wakeup_enable .literal.gpio_wakeup_disable .literal.gpio_set_drive_capability .literal.gpio_get_drive_capability .literal.gpio_hold_en .literal.gpio_hold_dis .literal.gpio_deep_sleep_hold_en .literal.gpio_deep_sleep_hold_dis .text.rtc_gpio_is_valid_gpio .text.gpio_output_disable .text.gpio_output_enable .text.gpio_intr_enable_on_core .text.gpio_pullup_en .text.gpio_pullup_dis .text.gpio_pulldown_en .text.gpio_pulldown_dis .text.gpio_set_intr_type .text.gpio_intr_enable .text.gpio_intr_disable .text.gpio_set_level .text.gpio_get_level .text.gpio_set_pull_mode .text.gpio_set_direction .text.gpio_config .text.gpio_reset_pin .text.gpio_isr_handler_add .text.gpio_isr_handler_remove .text.gpio_uninstall_isr_service .text.gpio_isr_register .text.gpio_install_isr_service .text.gpio_wakeup_enable .text.gpio_wakeup_disable .text.gpio_set_drive_capability .text.gpio_get_drive_capability .text.gpio_hold_en .text.gpio_hold_dis .text.gpio_deep_sleep_hold_en .text.gpio_deep_sleep_hold_dis)
    *libesp_event.a:default_event_loop.*(.literal.esp_event_handler_register .literal.esp_event_handler_unregister .literal.esp_event_post .literal.esp_event_loop_create_default .literal.esp_event_loop_delete_default .literal.esp_event_send_to_default_loop .text.esp_event_handler_register .text.esp_event_handler_unregister .text.esp_event_post .text.esp_event_loop_create_default .text.esp_event_loop_delete_default .text.esp_event_send_to_default_loop)
    *libesp_event.a:esp_event.*(.literal.handler_instances_remove_all$isra$1 .literal.handler_instances_add$isra$2 .literal.base_node_add_handler .literal.loop_node_add_handler .literal.handler_instances_remove$isra$3 .literal.esp_event_loop_create .literal.esp_event_loop_run .literal.esp_event_loop_run_task .literal.esp_event_loop_delete .literal.esp_event_handler_register_with .literal.esp_event_handler_unregister_with .literal.esp_event_post_to .text.handler_instances_remove_all$isra$1 .text.handler_instances_add$isra$2 .text.base_node_add_handler .text.loop_node_add_handler .text.handler_instances_remove$isra$3 .text.esp_event_loop_create .text.esp_event_loop_run .text.esp_event_loop_run_task .text.esp_event_loop_delete .text.esp_event_handler_register_with .text.esp_event_handler_unregister_with .text.esp_event_post_to .text.esp_event_dump)
    *libfreertos.a:port.*( .phyiram.*  .wifi0iram.*  .wifirxiram.*)
    *libfreertos.a:tasks.*( .phyiram.*  .wifi0iram.*  .wifirxiram.*)
    *libfreertos.a:port.*(.literal.pxPortInitialiseStack .phyiram.pxPortInitialiseStack .text.pxPortInitialiseStack .wifi0iram.pxPortInitialiseStack .wifirxiram.pxPortInitialiseStack)
    *libfreertos.a:port.*(.literal.xPortStartScheduler .phyiram.xPortStartScheduler .text.xPortStartScheduler .wifi0iram.xPortStartScheduler .wifirxiram.xPortStartScheduler)
    *libfreertos.a:tasks.*(.literal.vTaskStartScheduler .phyiram.vTaskStartScheduler .text.vTaskStartScheduler .wifi0iram.vTaskStartScheduler .wifirxiram.vTaskStartScheduler)

    *(.stub .gnu.warning .gnu.linkonce.literal.* .gnu.linkonce.t.*.literal .gnu.linkonce.t.*)
    *(.irom0.text) /* catch stray ICACHE_RODATA_ATTR */
    *(.fini.literal)
    *(.fini)
    *(.gnu.version)
    _text_end = ABSOLUTE(.);
    _etext = .;

    /* Similar to _iram_start, this symbol goes here so it is
       resolved by addr2line in preference to the first symbol in
       the flash.text segment.
    */
    _flash_cache_start = ABSOLUTE(0);
  } >iram0_2_seg
}
