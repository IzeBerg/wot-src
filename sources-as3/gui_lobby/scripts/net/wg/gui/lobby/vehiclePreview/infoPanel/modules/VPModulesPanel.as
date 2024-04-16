package net.wg.gui.lobby.vehiclePreview.infoPanel.modules
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.lobby.components.data.DeviceSlotVO;
   import net.wg.gui.lobby.modulesPanel.DeviceIndexHelper;
   import net.wg.gui.lobby.modulesPanel.ModulesPanel;
   import net.wg.gui.lobby.modulesPanel.interfaces.IModuleSlot;
   import net.wg.utils.IScheduler;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   
   public class VPModulesPanel extends ModulesPanel implements IStageSizeDependComponent
   {
      
      private static const TITLE_VERTICAL_OFFSET:int = 13;
      
      private static const SMALL_SLOTS_OFFSET:int = 55;
      
      private static const BIG_SLOTS_OFFSET:int = 65;
      
      private static const START_DELAY:int = 200;
      
      private static const DELAY:int = 600;
       
      
      public var gunTitleTF:TextField;
      
      public var turretTitleTF:TextField;
      
      public var engineTitleTF:TextField;
      
      public var chassisTitleTF:TextField;
      
      public var radioTitleTF:TextField;
      
      private var _titles:Vector.<TextField>;
      
      private var _scheduler:IScheduler;
      
      public function VPModulesPanel()
      {
         this._scheduler = App.utils.scheduler;
         super();
      }
      
      override public function playAnimation() : void
      {
         var _loc1_:IModuleSlot = null;
         var _loc2_:int = _modules.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _modules[_loc3_];
            _loc1_.resetAnimation();
            this._scheduler.scheduleTask(_loc1_.playAnimation,_loc3_ * DELAY + START_DELAY);
            _loc3_++;
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._titles = new <TextField>[this.gunTitleTF,this.turretTitleTF,this.chassisTitleTF,this.engineTitleTF,this.radioTitleTF];
         App.stageSizeMgr.register(this);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         this.gunTitleTF.mouseWheelEnabled = this.gunTitleTF.mouseEnabled = false;
         this.turretTitleTF.mouseWheelEnabled = this.turretTitleTF.mouseEnabled = false;
         this.engineTitleTF.mouseWheelEnabled = this.engineTitleTF.mouseEnabled = false;
         this.chassisTitleTF.mouseWheelEnabled = this.chassisTitleTF.mouseEnabled = false;
         this.radioTitleTF.mouseWheelEnabled = this.radioTitleTF.mouseEnabled = false;
      }
      
      override protected function onBeforeDispose() : void
      {
         var _loc1_:int = _modules.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._scheduler.cancelTask(_modules[_loc2_].playAnimation);
            _loc2_++;
         }
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._titles.length = 0;
         this._titles = null;
         this.gunTitleTF = null;
         this.turretTitleTF = null;
         this.engineTitleTF = null;
         this.chassisTitleTF = null;
         this.radioTitleTF = null;
         this._scheduler = null;
         super.onDispose();
      }
      
      override protected function trySetupDevice(param1:DeviceSlotVO) : Boolean
      {
         var _loc2_:int = DeviceIndexHelper.getDeviceIndex(param1.slotType);
         if(_loc2_ != -1)
         {
            _slots[_loc2_].update(param1);
            this._titles[_loc2_].text = param1.name;
            return true;
         }
         return false;
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:int = param2 <= StageSizeBoundaries.HEIGHT_900 ? int(SMALL_SLOTS_OFFSET) : int(BIG_SLOTS_OFFSET);
         var _loc4_:int = _slots.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _slots[_loc5_].y = _loc5_ * _loc3_;
            this._titles[_loc5_].y = TITLE_VERTICAL_OFFSET + _loc5_ * _loc3_;
            _loc5_++;
         }
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      override public function get height() : Number
      {
         if(radio)
         {
            return radio.y + radio.height;
         }
         return super.height;
      }
   }
}
