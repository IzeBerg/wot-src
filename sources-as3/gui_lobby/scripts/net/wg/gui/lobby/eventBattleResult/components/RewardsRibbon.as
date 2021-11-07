package net.wg.gui.lobby.eventBattleResult.components
{
   import flash.display.MovieClip;
   import net.wg.gui.lobby.eventBattleResult.constants.BattlePageSize;
   import net.wg.gui.lobby.linkedSet.components.AnimatedMovieClipContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.StageSizeBoundaries;
   
   public class RewardsRibbon extends AnimatedMovieClipContainer implements IDisposable
   {
      
      private static const BG_SIZE_NORMAL:int = 222;
      
      private static const BG_SIZE_SMALL:int = 184;
      
      private static const BG_SIZE_XSMALL:int = 156;
      
      private static const BG_SIZE_EXTRA:int = 20;
      
      private static const LINE_PADDING_NORMAL:int = 24;
      
      private static const LINE_PADDING_SMALL:int = 16;
      
      private static const LINE_PADDING_XSMALL:int = 8;
      
      private static const WIN:String = "Win";
      
      private static const LOOSE:String = "Loose";
       
      
      public var lineBottom:MovieClip = null;
      
      public var lineTop:MovieClip = null;
      
      public var _bgExtraSize:int = 0;
      
      public var _bgYOffset:int = 0;
      
      public var _contentSize:int = 0;
      
      public function RewardsRibbon()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.lineBottom = null;
         this.lineTop = null;
         super.onDispose();
      }
      
      public function getContentSize() : int
      {
         return this._contentSize;
      }
      
      public function setSizeFrame(param1:int) : void
      {
         if(param1 == BattlePageSize.NORMAL)
         {
            this.updateLayout(BG_SIZE_NORMAL,LINE_PADDING_NORMAL);
         }
         else if(param1 == BattlePageSize.SMALL)
         {
            this.updateLayout(BG_SIZE_SMALL,LINE_PADDING_SMALL);
         }
         else if(param1 == BattlePageSize.EXTRA_SMALL)
         {
            this.updateLayout(BG_SIZE_XSMALL,LINE_PADDING_XSMALL);
         }
      }
      
      public function setStageWidth(param1:int) : void
      {
         if(param1 > StageSizeBoundaries.WIDTH_1920)
         {
            content.width = param1;
         }
         else
         {
            content.width = StageSizeBoundaries.WIDTH_1920;
         }
      }
      
      public function setWin(param1:Boolean) : void
      {
         this._bgExtraSize = !!param1 ? int(0) : int(BG_SIZE_EXTRA);
         this._bgYOffset = !!param1 ? int(0) : int(1);
         frame = !!param1 ? WIN : LOOSE;
      }
      
      private function updateLayout(param1:int, param2:int) : void
      {
         this._contentSize = param1;
         content.height = this._contentSize + this._bgExtraSize;
         var _loc3_:int = this._contentSize >> 1;
         content.y = -_loc3_ - this._bgYOffset;
         this.lineBottom.y = _loc3_ - this.lineBottom.height - param2 | 0;
         this.lineTop.y = -_loc3_ + param2;
      }
   }
}
