package net.wg.gui.battle.mapsTraining.views.prebattleTimer
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MapsTrainingTextFieldContainer extends MovieClip implements IDisposable
   {
      
      private static const SIZE_NORMAL:String = "normal";
      
      private static const SIZE_SMALL:String = "small";
       
      
      public var container:TextFieldContainer = null;
      
      private var _disposed:Boolean = false;
      
      public function MapsTrainingTextFieldContainer()
      {
         super();
      }
      
      public function setSize(param1:Boolean, param2:int) : void
      {
         gotoAndStop(!!param1 ? SIZE_SMALL : SIZE_NORMAL);
         this.container.fontSize = param2;
      }
      
      public function set label(param1:String) : void
      {
         this.container.label = param1;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.container.dispose();
         this.container = null;
      }
      
      public function set offset(param1:int) : void
      {
         this.container.y = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
