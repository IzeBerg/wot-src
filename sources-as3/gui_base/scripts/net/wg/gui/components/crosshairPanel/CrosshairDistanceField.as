package net.wg.gui.components.crosshairPanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CrosshairDistanceField extends MovieClip implements IDisposable
   {
       
      
      public var distanceTF:TextField = null;
      
      private var _distance:String = "";
      
      public function CrosshairDistanceField()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.distanceTF = null;
      }
      
      public function setDistance(param1:String) : void
      {
         if(this._distance != param1)
         {
            this._distance = param1;
            this.distanceTF.text = this._distance;
         }
      }
   }
}
