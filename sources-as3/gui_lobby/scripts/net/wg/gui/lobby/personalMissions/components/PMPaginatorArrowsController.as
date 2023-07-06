package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.DisplayObjectContainer;
   import net.wg.data.constants.generated.MISSIONS_STATES;
   import net.wg.gui.components.paginator.PaginationDetailsNumButton;
   import net.wg.gui.components.paginator.PaginationGroup;
   import net.wg.gui.components.paginator.PaginatorArrowsController;
   import net.wg.gui.components.paginator.vo.PaginatorPageNumVO;
   import net.wg.gui.interfaces.ISoundButtonEx;
   
   public class PMPaginatorArrowsController extends PaginatorArrowsController
   {
       
      
      public function PMPaginatorArrowsController(param1:DisplayObjectContainer, param2:PaginationGroup, param3:ISoundButtonEx, param4:ISoundButtonEx, param5:String, param6:int = 0, param7:Boolean = false, param8:int = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      override protected function getFirstMissionIndex() : int
      {
         return this.getEnabledIdx(super.getFirstMissionIndex());
      }
      
      override protected function getLastMissionIndex() : int
      {
         return this.getEnabledIdx(super.getLastMissionIndex(),false);
      }
      
      override protected function arrowRightBtnClickHandler() : void
      {
         setPageIndex(this.getEnabledIdx(getPageIndex() + 1));
      }
      
      override protected function arrowLeftBtnClickHandler() : void
      {
         setPageIndex(this.getEnabledIdx(getPageIndex() - 1,false));
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
      }
      
      override protected function showArrowTooltip(param1:int) : void
      {
         var _loc2_:PaginationDetailsNumButton = PaginationDetailsNumButton(gatButtonByIndex(param1));
         if(_loc2_)
         {
            _loc2_.showTooltip();
         }
      }
      
      private function getEnabledIdx(param1:int, param2:Boolean = true) : int
      {
         var _loc3_:PaginatorPageNumVO = PaginatorPageNumVO(getPageDataByIdx(param1));
         var _loc4_:int = !!param2 ? int(1) : int(-1);
         while(_loc3_.status == MISSIONS_STATES.DISABLED)
         {
            param1 += _loc4_;
            _loc3_ = PaginatorPageNumVO(getPageDataByIdx(param1));
         }
         return param1;
      }
   }
}
