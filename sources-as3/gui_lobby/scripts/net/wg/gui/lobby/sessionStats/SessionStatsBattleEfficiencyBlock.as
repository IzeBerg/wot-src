package net.wg.gui.lobby.sessionStats
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.containers.VerticalGroupLayout;
   
   public class SessionStatsBattleEfficiencyBlock extends SessionStatsBattleResultBlock
   {
      
      private static const SMALL_Y:int = 9;
      
      private static const BIG_Y:int = 50;
       
      
      public var title:TextField = null;
      
      public function SessionStatsBattleEfficiencyBlock()
      {
         super();
         this.title.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override public function setBlockWidth(param1:int) : void
      {
      }
      
      override public function initLayout() : void
      {
         var _loc1_:VerticalGroupLayout = new VerticalGroupLayout();
         _loc1_.gap = SessionBattleStatsView.COLLAPSE_GAP;
         list.layout = _loc1_;
         list.itemRendererLinkage = Linkages.SESSION_BATTLE_EFFICIENCY_STATS_RENDERER_UI;
      }
      
      override protected function applyData() : void
      {
         list.dataProvider = dataVO.battleEfficiency;
         this.title.htmlText = dataVO.collapseLabel;
         list.y = dataVO.collapseLabel == Values.EMPTY_STR ? Number(SMALL_Y) : Number(BIG_Y);
      }
      
      override protected function onDispose() : void
      {
         this.title = null;
         super.onDispose();
      }
   }
}
