package net.wg.gui.battle.halloween.playersList
{
   import net.wg.infrastructure.base.meta.IHWPlayersPanelMeta;
   import net.wg.infrastructure.base.meta.impl.HWPlayersPanelMeta;
   
   public class HWPlayersPanel extends HWPlayersPanelMeta implements IHWPlayersPanelMeta
   {
       
      
      public function HWPlayersPanel()
      {
         super();
      }
      
      public function as_setPlayerBuff(param1:Boolean, param2:int, param3:String) : void
      {
         if(param1)
         {
            HWPlayersPanelList(listLeft).setBuffIcon(param2,param3);
         }
         else
         {
            HWPlayersPanelList(listRight).setBuffIcon(param2,param3);
         }
      }
   }
}
