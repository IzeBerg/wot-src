package net.wg.gui.battle.views.battleHint.containers
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.views.battleHint.constants.HINT_LABELS;
   import net.wg.gui.battle.views.battleHint.vo.BattleHintVO;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.StageSizeBoundaries;
   
   public class HintContainer extends MovieClip implements IDisposable
   {
      
      private static const DEFAULT_IMAGE_HEIGHT:int = 100;
       
      
      public var txt:HintInfoContainer = null;
      
      public var highlight:HintHighlightContainer = null;
      
      public var icon:HintIconContainer = null;
      
      private var _disposed:Boolean = false;
      
      public function HintContainer()
      {
         super();
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler,false,0,true);
         this.highlight.setTextField(this.txt.txt);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         this.icon.dispose();
         this.icon = null;
         this.txt.dispose();
         this.txt = null;
         this.highlight.dispose();
         this.highlight = null;
      }
      
      public function updateStage(param1:Number) : void
      {
         this.txt.setIsBigSize(param1 >= StageSizeBoundaries.WIDTH_1920);
         this.highlight.updatePosition();
      }
      
      public function hideHint() : void
      {
         gotoAndPlay(HINT_LABELS.HIDE_LABEL);
      }
      
      public function showHint(param1:BattleHintVO) : void
      {
         gotoAndPlay(HINT_LABELS.SHOW_LABEL);
         this.icon.setHintData(param1.iconSource);
         this.txt.setMessage(param1.message);
         this.highlight.setHighlight(param1.messageHighlight);
      }
      
      public function stopHint() : void
      {
         gotoAndStop(1);
         this.txt.clear();
         this.icon.clear();
         this.highlight.clear();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      private function onIconCompleteHandler(param1:UILoaderEvent) : void
      {
         this.txt.setOffset(this.icon.y + this.icon.height - DEFAULT_IMAGE_HEIGHT);
         this.highlight.updatePosition();
      }
   }
}
