package net.wg.gui.lobby.rankedBattles19.components.rankAward
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class GlowRankAnimation extends MovieClip implements IDisposable
   {
       
      
      public var rankIcon:RankContainer = null;
      
      public var reflectionMc:MovieClip = null;
      
      public var shineMc:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function GlowRankAnimation()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function hideEffects() : void
      {
         this.reflectionMc.visible = false;
         this.shineMc.visible = false;
      }
      
      public function showReflectionEffect(param1:Boolean) : void
      {
         if(param1)
         {
            this.reflectionMc.gotoAndPlay(1);
         }
         else
         {
            this.reflectionMc.gotoAndStop(1);
         }
      }
      
      protected function onDispose() : void
      {
         this._disposed = true;
         this.reflectionMc.stop();
         this.shineMc.stop();
         stop();
         this.rankIcon.dispose();
         this.rankIcon = null;
         this.reflectionMc = null;
         this.shineMc = null;
      }
      
      public function set source(param1:String) : void
      {
         this.rankIcon.source = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
