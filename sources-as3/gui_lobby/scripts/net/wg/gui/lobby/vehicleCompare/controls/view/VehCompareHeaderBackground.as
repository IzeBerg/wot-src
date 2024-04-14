package net.wg.gui.lobby.vehicleCompare.controls.view
{
   import flash.display.Sprite;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehCompareHeaderBackground extends UIComponentEx
   {
       
      
      public var separator:Sprite;
      
      private var _backHitArea:Sprite;
      
      public function VehCompareHeaderBackground()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._backHitArea = new Sprite();
         addChild(this._backHitArea);
         this.separator.hitArea = this._backHitArea;
         this.separator.mouseChildren = this.separator.mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         removeChild(this._backHitArea);
         this._backHitArea = null;
         this.separator.hitArea = null;
         this.separator = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.separator.width = width;
            this.separator.x = width;
         }
      }
   }
}
