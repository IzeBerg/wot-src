package net.wg.gui.lobby.rankedBattles19.rankedBattlesBattleResults
{
   import net.wg.gui.components.controls.SimpleTileList;
   
   public class RankedSimpleTileList extends SimpleTileList
   {
       
      
      private var _isCompact:Boolean = false;
      
      public function RankedSimpleTileList()
      {
         super();
      }
      
      override protected function updateLayout() : void
      {
         var _loc2_:PlayerRankedRenderer = null;
         super.updateLayout();
         var _loc1_:int = length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = PlayerRankedRenderer(getRendererAt(_loc3_));
            _loc2_.setCompact(this._isCompact);
            _loc3_++;
         }
      }
      
      public function setCompact(param1:Boolean) : void
      {
         if(param1 != this._isCompact)
         {
            App.toolTipMgr.hide();
            this._isCompact = param1;
            invalidate(INVALIDATE_LAYOUT);
         }
      }
   }
}
