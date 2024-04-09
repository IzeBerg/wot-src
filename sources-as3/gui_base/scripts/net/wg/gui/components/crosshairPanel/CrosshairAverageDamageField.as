package net.wg.gui.components.crosshairPanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CrosshairAverageDamageField extends MovieClip implements IDisposable
   {
       
      
      public var averageDamageTF:TextField = null;
      
      private var _disposed:Boolean = false;
      
      private var _distance:String = "";
      
      public function CrosshairAverageDamageField()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.averageDamageTF = null;
      }
      
      public function setAverageDamage(param1:String) : void
      {
         if(this._distance != param1)
         {
            this._distance = param1;
            this.averageDamageTF.text = this._distance;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
