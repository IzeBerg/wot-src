package net.wg.gui.lobby.vehPostProgression.components
{
   import net.wg.gui.lobby.components.VehicleButton;
   import net.wg.gui.lobby.components.data.VehicleButtonVO;
   import net.wg.gui.lobby.techtree.controls.ExperienceBlock;
   import net.wg.gui.lobby.vehPostProgression.data.VehicleInfoVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehicleBlock extends UIComponentEx
   {
      
      private static const BIG_VEHICLE_BOTTOM_Y_GAP:int = -8;
      
      private static const SMALL_VEHICLE_BOTTOM_Y_GAP:int = -8;
      
      private static const VEHICLE_BUTTON_UI:String = "VehicleButtonUI";
      
      private static const XP_INFO:String = "ExperienceInfo";
      
      private static const OFFSET_X_RATE:Number = 0.05;
       
      
      private var _vehicleButton:VehicleButton = null;
      
      private var _experienceBlock:ExperienceBlock = null;
      
      private var _size:String = "large_";
      
      public function VehicleBlock()
      {
         super();
         this._vehicleButton = App.utils.classFactory.getComponent(VEHICLE_BUTTON_UI,VehicleButton);
         this._vehicleButton.name = VEHICLE_BUTTON_UI;
         addChild(this._vehicleButton);
         this._experienceBlock = App.utils.classFactory.getComponent(XP_INFO,ExperienceBlock);
         this._experienceBlock.name = XP_INFO;
         addChild(this._experienceBlock);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayouts();
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this._experienceBlock.updateWalletStatus();
         }
      }
      
      override protected function onDispose() : void
      {
         this._experienceBlock.dispose();
         this._experienceBlock = null;
         this._vehicleButton.dispose();
         this._vehicleButton = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      public function setButtonData(param1:VehicleButtonVO) : void
      {
         this._vehicleButton.setData(param1);
      }
      
      public function setExpBlockVisible(param1:Boolean) : void
      {
         this._experienceBlock.visible = param1;
      }
      
      public function setVehicleInfo(param1:VehicleInfoVO) : void
      {
         this._experienceBlock.setData(param1.earnedXP,param1.isElite);
         this._experienceBlock.freeXP = param1.freeExp;
      }
      
      public function updateWalletStatus() : void
      {
         this._experienceBlock.updateWalletStatus();
      }
      
      private function updateLayouts() : void
      {
         var _loc1_:int = 0;
         this._vehicleButton.x = -this.contentWidth * OFFSET_X_RATE;
         _loc1_ = this._vehicleButton.contentHeight >> 1;
         var _loc2_:int = _loc1_ + (Boolean(VehicleButton.SMALL_SIZE) ? SMALL_VEHICLE_BOTTOM_Y_GAP : BIG_VEHICLE_BOTTOM_Y_GAP);
         this._experienceBlock.validateNow();
         this._experienceBlock.x = -this._experienceBlock.actualWidth >> 1;
         this._experienceBlock.y = _loc2_;
      }
      
      public function get contentWidth() : Number
      {
         return this._vehicleButton.contentWidth;
      }
      
      public function get contentHeight() : Number
      {
         return this._vehicleButton.contentHeight;
      }
      
      public function set size(param1:String) : void
      {
         if(this._size != param1)
         {
            this._size = param1;
            this._vehicleButton.size = param1;
            this._vehicleButton.validateNow();
            invalidateSize();
         }
      }
   }
}
