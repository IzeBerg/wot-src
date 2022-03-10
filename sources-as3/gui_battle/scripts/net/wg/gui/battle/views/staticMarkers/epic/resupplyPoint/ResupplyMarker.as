package net.wg.gui.battle.views.staticMarkers.epic.resupplyPoint
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class ResupplyMarker extends Sprite implements IDisposable
   {
      
      private static const INSIDE_ALPHA_VALUE:Number = 0;
      
      private static const OUTSIDE_ALPHA_VALUE:Number = 1;
       
      
      public var cooldownTF:TextField = null;
      
      public var marker:ResupplyIcon = null;
      
      private var _disposed:Boolean = false;
      
      public function ResupplyMarker()
      {
         super();
         TextFieldEx.setNoTranslate(this.cooldownTF,true);
         this.marker.visible = true;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.marker.dispose();
         this.marker = null;
         this.cooldownTF = null;
      }
      
      public function notifyVehicleInCircle(param1:Boolean) : void
      {
         if(param1)
         {
            this.marker.alpha = INSIDE_ALPHA_VALUE;
            this.cooldownTF.alpha = INSIDE_ALPHA_VALUE;
         }
         else
         {
            this.marker.alpha = OUTSIDE_ALPHA_VALUE;
            this.cooldownTF.alpha = OUTSIDE_ALPHA_VALUE;
         }
      }
      
      public function setCooldown(param1:String) : void
      {
         this.marker.setUnavailableState();
         this.cooldownTF.text = param1;
      }
      
      public function setState(param1:int) : void
      {
         this.marker.setState(param1);
         this.cooldownTF.text = Values.EMPTY_STR;
         this.cooldownTF.visible = param1 == 1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
