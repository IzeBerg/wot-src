package net.wg.gui.lobby.tankman
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class PersonalCaseSpecialization extends UIComponentEx
   {
      
      private static const TEXT_RIGHT_MARGIN:Number = 5;
       
      
      public var contourIcon:UILoaderAlt;
      
      public var vehicleType:TextField;
      
      private var _vType:String = "";
      
      private var _vIco:String = "";
      
      public function PersonalCaseSpecialization()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this.contourIcon.dispose();
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.vehicleType.htmlText = this._vType;
            this.contourIcon.x = this.vehicleType.x + this.vehicleType.textWidth + TEXT_RIGHT_MARGIN ^ 0;
            this.contourIcon.source = this._vIco;
         }
      }
      
      public function setData(param1:String, param2:String) : void
      {
         this._vType = param1;
         this._vIco = param2;
         this.contourIcon.visible = this._vIco != null;
         invalidateData();
      }
   }
}
