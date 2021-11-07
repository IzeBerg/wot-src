package net.wg.gui.components.controls
{
   import scaleform.clik.controls.Button;
   
   [InspectableList("icoType")]
   public class AlertIco extends Button
   {
      
      public static var ALERT_ICO_SMALL:String = "alertSmall";
      
      public static var ALERT_ICO_BIG:String = "alertBig";
       
      
      private const INVALID_ICON:String = "iconIsInvalid";
      
      private var _icoType:String;
      
      public function AlertIco()
      {
         this._icoType = ALERT_ICO_BIG;
         super();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(this.INVALID_ICON))
         {
            gotoAndStop(this._icoType);
            this.setActualSize(this.actualWidth,this.actualHeight);
         }
         super.draw();
      }
      
      [Inspectable(defaultValue="alertBig",enumeration="alertBig,alertSmall")]
      public function get icoType() : String
      {
         return this._icoType;
      }
      
      public function set icoType(param1:String) : void
      {
         this._icoType = param1;
         invalidate(this.INVALID_ICON);
      }
   }
}
