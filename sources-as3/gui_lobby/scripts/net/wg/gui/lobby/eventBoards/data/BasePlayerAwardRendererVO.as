package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.VO.UserVO;
   
   public class BasePlayerAwardRendererVO extends BaseEventBoardTableRendererVO
   {
      
      private static const USER:String = "userVO";
       
      
      public var position:int = -1;
      
      public var userVO:UserVO = null;
      
      public var value1:String = "";
      
      public var value2:String = "";
      
      public var value3:String = "";
      
      public var valueTime:String = "";
      
      public var iconPath:String = "";
      
      public function BasePlayerAwardRendererVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == USER)
         {
            this.userVO = new UserVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.userVO != null)
         {
            this.userVO.dispose();
            this.userVO = null;
         }
         super.onDispose();
      }
   }
}
