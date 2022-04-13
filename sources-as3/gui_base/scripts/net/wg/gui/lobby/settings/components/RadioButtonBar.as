package net.wg.gui.lobby.settings.components
{
   import flash.utils.Dictionary;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.RadioButton;
   import scaleform.clik.controls.Button;
   
   public class RadioButtonBar extends ButtonBarEx
   {
      
      private static const SUPPORTED:String = "supported";
       
      
      private var _infoData:Dictionary;
      
      private var _warningData:Dictionary;
      
      private var _infoTooltipMaxWidth:uint = 0;
      
      public function RadioButtonBar()
      {
         this._infoData = new Dictionary();
         this._warningData = new Dictionary();
         super();
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
         App.utils.data.cleanupDynamicObject(this._infoData);
         this._infoData = null;
         App.utils.data.cleanupDynamicObject(this._warningData);
         this._warningData = null;
      }
      
      override protected function populateRendererData(param1:Button, param2:uint) : void
      {
         var _loc3_:Object = _dataProvider.requestItemAt(param2);
         if(_loc3_ && _loc3_.hasOwnProperty(SUPPORTED))
         {
            param1.enabled = _loc3_[SUPPORTED];
         }
         RadioButton(param1).setInfoIconTooltipWidth(this._infoTooltipMaxWidth);
         if(param2 in this._infoData)
         {
            RadioButton(param1).infoIcoType = InfoIcon.TYPE_INFO;
            RadioButton(param1).infoTooltip = this._infoData[param2];
         }
         if(param2 in this._warningData)
         {
            RadioButton(param1).infoIcoType = InfoIcon.TYPE_WARNING;
            RadioButton(param1).infoTooltip = this._warningData[param2];
         }
         super.populateRendererData(param1,param2);
      }
      
      public function setInfoButton(param1:String, param2:int) : void
      {
         this._infoData[param2] = param1;
      }
      
      public function setInfoIconTooltipWidth(param1:uint) : void
      {
         this._infoTooltipMaxWidth = param1;
      }
      
      public function setWarningButton(param1:String, param2:int) : void
      {
         this._warningData[param2] = param1;
      }
   }
}
