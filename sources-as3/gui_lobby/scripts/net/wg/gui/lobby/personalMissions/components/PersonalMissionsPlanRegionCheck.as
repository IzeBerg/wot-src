package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PersonalMissionsPlanRegionCheck extends MovieClip implements IDisposable
   {
       
      
      public var checkmarkImg:Image = null;
      
      private var _disposed:Boolean = false;
      
      public function PersonalMissionsPlanRegionCheck()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      private function onDispose() : void
      {
         this.checkmarkImg.dispose();
         this.checkmarkImg = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
