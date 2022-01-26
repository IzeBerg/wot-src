package net.wg.gui.lobby.missions.data
{
   public class CollapsedHeaderTitleBlockVO extends HeaderTitleBlockBaseVO
   {
      
      public static const ACTION_FIELD_NAME:String = "action";
       
      
      private var _actionVO:MissionHeaderActionVO;
      
      public function CollapsedHeaderTitleBlockVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == ACTION_FIELD_NAME)
         {
            this._actionVO = new MissionHeaderActionVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._actionVO)
         {
            this._actionVO.dispose();
            this._actionVO = null;
         }
         super.onDispose();
      }
      
      public function get actionVO() : MissionHeaderActionVO
      {
         return this._actionVO;
      }
   }
}
