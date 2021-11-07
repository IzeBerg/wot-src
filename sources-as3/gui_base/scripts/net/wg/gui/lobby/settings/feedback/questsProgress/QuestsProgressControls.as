package net.wg.gui.lobby.settings.feedback.questsProgress
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class QuestsProgressControls extends Sprite implements IDisposable
   {
       
      
      public var questsProgressIndicators:MovieClip = null;
      
      public var questsProgressIndicatorsWithFlag:MovieClip = null;
      
      public function QuestsProgressControls()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function setFlagVisible(param1:Boolean) : void
      {
         this.questsProgressIndicators.visible = !param1;
         this.questsProgressIndicatorsWithFlag.visible = param1;
      }
      
      protected function onDispose() : void
      {
         this.questsProgressIndicators = null;
         this.questsProgressIndicatorsWithFlag = null;
      }
   }
}
