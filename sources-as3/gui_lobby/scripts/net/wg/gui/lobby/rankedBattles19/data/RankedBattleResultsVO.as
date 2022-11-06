package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RankedBattleResultsVO extends DAAPIDataClass
   {
      
      private static const LEFT_BLOCK_DATA:String = "leftData";
      
      private static const RIGHT_BLOCK_DATA:String = "rightData";
       
      
      public var title:String = "";
      
      public var mainBackground:String = "";
      
      public var readyBtn:String = "";
      
      public var readyBtnVisible:Boolean = false;
      
      public var animationEnabledLabel:String = "";
      
      public var animationEnabled:Boolean = true;
      
      public var showWidgetAnimation:Boolean = true;
      
      public var statusText:String = "";
      
      public var state:String = "";
      
      private var _leftBlockVO:RankedListsVO = null;
      
      private var _rightBlockVO:RankedListsVO = null;
      
      public function RankedBattleResultsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == LEFT_BLOCK_DATA)
         {
            this._leftBlockVO = new RankedListsVO(param2);
            return false;
         }
         if(param1 == RIGHT_BLOCK_DATA)
         {
            this._rightBlockVO = new RankedListsVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._leftBlockVO.dispose();
         this._leftBlockVO = null;
         this._rightBlockVO.dispose();
         this._rightBlockVO = null;
         super.onDispose();
      }
      
      public function get leftData() : RankedListsVO
      {
         return this._leftBlockVO;
      }
      
      public function get rightData() : RankedListsVO
      {
         return this._rightBlockVO;
      }
   }
}
