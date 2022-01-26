package net.wg.gui.lobby.vehicleTradeWnds.sell
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.lobby.vehicleTradeWnds.sell.utils.VehicleSellDialogUtils;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class SettingsButton extends UIComponentEx
   {
      
      private static const INV_CREDITS_VISIBILITY:String = "invCreditsVisibility";
       
      
      public var setingsDropBtn:CheckBox = null;
      
      public var creditsIT:IconText = null;
      
      public var ddLine:MovieClip = null;
      
      private var _credits:int;
      
      private var _areCreditsVisible:Boolean;
      
      public function SettingsButton()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:String = App.utils.locale.makeString(DIALOGS.VEHICLESELLDIALOG_EXPANDBTNLABEL);
         _loc1_ = App.utils.toUpperOrLowerCase(_loc1_,true);
         this.setingsDropBtn.label = _loc1_;
         this.setingsDropBtn.addEventListener(Event.SELECT,this.onSlidingComponentSelectHandler);
         this._areCreditsVisible = !this.setingsDropBtn.selected;
         this.creditsIT.visible = this._areCreditsVisible;
         this.creditsIT.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
      }
      
      override protected function onDispose() : void
      {
         this.setingsDropBtn.removeEventListener(Event.SELECT,this.onSlidingComponentSelectHandler);
         this.setingsDropBtn.dispose();
         this.setingsDropBtn = null;
         this.creditsIT.dispose();
         this.creditsIT = null;
         this.ddLine = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.creditsIT.text = VehicleSellDialogUtils.getCost(this._credits,CURRENCIES_CONSTANTS.CREDITS);
         }
         if(isInvalid(INV_CREDITS_VISIBILITY))
         {
            this.creditsIT.visible = this._areCreditsVisible;
         }
      }
      
      public function setData(param1:int) : void
      {
         if(this._credits == param1)
         {
            return;
         }
         this._credits = param1;
         invalidateData();
      }
      
      private function onSlidingComponentSelectHandler(param1:Event) : void
      {
         this._areCreditsVisible = !this.setingsDropBtn.selected;
         invalidate(INV_CREDITS_VISIBILITY);
      }
   }
}
