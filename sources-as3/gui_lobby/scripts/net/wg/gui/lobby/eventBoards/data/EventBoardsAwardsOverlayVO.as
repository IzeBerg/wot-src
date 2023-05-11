package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EventBoardsAwardsOverlayVO extends DAAPIDataClass
   {
      
      private static const AWARDS_DATA:String = "awardsData";
       
      
      public var bgPath:String = "";
      
      public var title:String = "";
      
      public var eventID:String = "";
      
      private var _awardsTableVO:AwardsTableVO = null;
      
      public function EventBoardsAwardsOverlayVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == AWARDS_DATA)
         {
            this._awardsTableVO = new AwardsTableVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._awardsTableVO != null)
         {
            this._awardsTableVO.dispose();
            this._awardsTableVO = null;
         }
         super.onDispose();
      }
      
      public function get awardsTableVO() : AwardsTableVO
      {
         return this._awardsTableVO;
      }
   }
}
