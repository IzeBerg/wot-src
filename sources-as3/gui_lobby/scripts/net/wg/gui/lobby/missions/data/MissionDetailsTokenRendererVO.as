package net.wg.gui.lobby.missions.data
{
   public class MissionDetailsTokenRendererVO extends TokenRendererVO
   {
      
      private static const TITLE_TEXT:String = "titleText";
       
      
      public var bigTitleText:String = "";
      
      public function MissionDetailsTokenRendererVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == TITLE_TEXT)
         {
            this.bigTitleText = String(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }
}
