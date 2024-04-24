package net.wg.gui.lobby.clans.profile
{
   public class ClanProfileSummaryViewHeader extends ClanProfileMainWindowBaseHeader
   {
      
      private static const TF_GAP:int = 5;
      
      private static const TF_BLOCK_CENTER_Y:int = 187;
       
      
      public function ClanProfileSummaryViewHeader()
      {
         super();
      }
      
      override protected function updateClanTexts(param1:String, param2:String) : void
      {
         App.utils.commons.truncateTextFieldText(clanNameTF,param1,false);
         creationDateTF.htmlText = param2;
         var _loc3_:int = clanNameTF.textHeight + TF_GAP + creationDateTF.textHeight;
         clanNameTF.y = TF_BLOCK_CENTER_Y - (_loc3_ >> 1);
         creationDateTF.y = clanNameTF.y + clanNameTF.textHeight + TF_GAP >> 0;
      }
      
      override protected function setClanEmblemShadowFilter() : void
      {
         var _loc1_:Number = 10;
         var _loc2_:Number = 90;
         var _loc3_:Number = 1;
         var _loc4_:Number = 33;
         var _loc5_:Number = 33;
         var _loc6_:Number = 0.8;
         App.utils.commons.setShadowFilterWithParams(clanEmblem,_loc1_,_loc2_,EMBLEM_SHADOW_COLOR,_loc3_,_loc4_,_loc5_,_loc6_);
      }
   }
}
