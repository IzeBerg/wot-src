package net.wg.gui.lobby.clans.profile.VOs
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.advanced.vo.TruncateHtmlTextVO;
   
   public class ClanProfileStatsLineVO extends DAAPIDataClass
   {
      
      private static const TRUNCATE_VO:String = "truncateVo";
       
      
      public var label:String = "";
      
      public var value:String = "";
      
      public var tooltipHeader:String = "";
      
      public var tooltipBody:String = "";
      
      public var isUseTextStyle:Boolean = false;
      
      public var isHidden:Boolean = false;
      
      public var truncateVo:TruncateHtmlTextVO = null;
      
      public function ClanProfileStatsLineVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == TRUNCATE_VO && param2 != null)
         {
            this.cleanInternalVo();
            this.truncateVo = new TruncateHtmlTextVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.cleanInternalVo();
         super.onDispose();
      }
      
      private function cleanInternalVo() : void
      {
         if(this.truncateVo != null)
         {
            this.truncateVo.dispose();
            this.truncateVo = null;
         }
      }
   }
}
