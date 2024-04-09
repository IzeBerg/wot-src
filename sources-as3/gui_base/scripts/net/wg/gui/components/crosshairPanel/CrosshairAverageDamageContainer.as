package net.wg.gui.components.crosshairPanel
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CrosshairAverageDamageContainer extends MovieClip implements IDisposable
   {
      
      private static const AD_SHOW_FRAME:uint = 1;
      
      private static const AD_START_HIDE_FRAME:uint = 2;
      
      private static const AD_HIDE_FRAME:uint = 60;
       
      
      public var averageDamageField:CrosshairAverageDamageField = null;
      
      private var _isClear:Boolean = true;
      
      private var _disposed:Boolean = false;
      
      public function CrosshairAverageDamageContainer()
      {
         super();
         visible = false;
      }
      
      public function clearAverageDamage(param1:Boolean) : void
      {
         if(this._isClear)
         {
            return;
         }
         if(param1)
         {
            gotoAndStop(AD_HIDE_FRAME);
         }
         else
         {
            gotoAndPlay(AD_START_HIDE_FRAME);
         }
         this._isClear = true;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         if(this.averageDamageField)
         {
            this.averageDamageField.dispose();
            this.averageDamageField = null;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setAverageDamage(param1:String) : void
      {
         if(param1 != Values.EMPTY_STR)
         {
            visible = true;
            this._isClear = false;
            gotoAndStop(AD_SHOW_FRAME);
            this.averageDamageField.setAverageDamage(param1);
         }
         else
         {
            visible = false;
         }
      }
   }
}
