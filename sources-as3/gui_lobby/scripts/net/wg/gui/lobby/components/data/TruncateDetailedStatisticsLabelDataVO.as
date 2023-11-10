package net.wg.gui.lobby.components.data
{
   import net.wg.gui.components.advanced.vo.TruncateHtmlTextVO;
   
   public class TruncateDetailedStatisticsLabelDataVO extends DetailedStatisticsLabelDataVO
   {
      
      public static const TRUNCATE_VO:String = "truncateVo";
       
      
      private var _truncateVo:TruncateHtmlTextVO = null;
      
      public function TruncateDetailedStatisticsLabelDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == TRUNCATE_VO)
         {
            this._truncateVo = new TruncateHtmlTextVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._truncateVo.dispose();
         this._truncateVo = null;
         super.onDispose();
      }
      
      public function get truncateVo() : TruncateHtmlTextVO
      {
         return this._truncateVo;
      }
   }
}
