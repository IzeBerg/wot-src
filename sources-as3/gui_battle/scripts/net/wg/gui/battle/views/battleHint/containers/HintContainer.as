package net.wg.gui.battle.views.battleHint.containers
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.views.battleHint.constants.HINT_LABELS;
   import net.wg.gui.battle.views.battleHint.vo.BattleHintVO;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HintContainer extends MovieClip implements IDisposable
   {
       
      
      public var txt:HintInfoContainer = null;
      
      public var icon:HintIconContainer = null;
      
      private const TXT_PADDING:int = -100;
      
      private var _disposed:Boolean = false;
      
      public function HintContainer()
      {
         super();
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler,false,0,true);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         this.icon.dispose();
         this.icon = null;
         this.txt.dispose();
         this.txt = null;
      }
      
      public function hideHint() : void
      {
         gotoAndPlay(HINT_LABELS.HIDE_LABEL);
      }
      
      public function showHint(param1:BattleHintVO) : void
      {
         gotoAndPlay(HINT_LABELS.SHOW_LABEL);
         this.icon.setHintData(param1.iconSource);
         this.txt.setHintData(param1.message,param1.messageHighlight);
      }
      
      public function stopHint() : void
      {
         gotoAndStop(1);
         this.txt.clear();
         this.icon.clear();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      private function onIconCompleteHandler(param1:UILoaderEvent) : void
      {
         this.txt.setOffset(this.icon.y + this.icon.height + this.TXT_PADDING);
      }
   }
}
