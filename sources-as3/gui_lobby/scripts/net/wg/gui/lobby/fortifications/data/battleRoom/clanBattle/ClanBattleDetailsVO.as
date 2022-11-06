package net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle
{
   import net.wg.gui.rally.vo.RallyShortVO;
   
   public class ClanBattleDetailsVO extends RallyShortVO
   {
       
      
      public var isCreationAvailable:Boolean = true;
      
      public var titleText:String = "";
      
      public var descrText:String = "";
      
      public var buttonLbl:String = "";
      
      public var isEnableBtn:Boolean = false;
      
      public var detailsTitle:String = "";
      
      public function ClanBattleDetailsVO(param1:Object)
      {
         super(param1);
      }
   }
}
