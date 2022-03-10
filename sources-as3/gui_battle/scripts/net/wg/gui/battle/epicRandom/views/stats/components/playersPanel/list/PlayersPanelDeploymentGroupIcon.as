package net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PlayersPanelDeploymentGroupIcon extends MovieClip implements IDisposable
   {
      
      private static const COLORBLIND_SCHEME:String = "colorblind";
      
      private static const DEFAULT_SCHEME:String = "default";
      
      private static const TINY_STATE_SIZE:int = 56;
      
      private static const SHORT_STATE_SIZE:int = 132;
      
      private static const MEDIUM_STATE_SIZE:int = 200;
       
      
      public var groupIdTF:TextField = null;
      
      public var hitBox:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function PlayersPanelDeploymentGroupIcon()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function setColorblind(param1:Boolean) : void
      {
         gotoAndStop(!!param1 ? COLORBLIND_SCHEME : DEFAULT_SCHEME);
      }
      
      public function setSize(param1:uint) : void
      {
         if(PlayersPanelListItemState.TINY_STATES.indexOf(param1) > 1)
         {
            this.hitBox.width = TINY_STATE_SIZE;
         }
         else if(PlayersPanelListItemState.MEDIUM_STATES.indexOf(param1) > 1)
         {
            this.hitBox.width = MEDIUM_STATE_SIZE;
         }
         else if(PlayersPanelListItemState.SHORT_STATES.indexOf(param1) > 1)
         {
            this.hitBox.width = SHORT_STATE_SIZE;
         }
      }
      
      public function setText(param1:String) : void
      {
         this.groupIdTF.text = param1;
      }
      
      private function onDispose() : void
      {
         this.groupIdTF = null;
         this.hitBox = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
