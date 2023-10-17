package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.sessionStats.data.SessionBattleStatsViewVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class SessionBattleStatsViewMeta extends BaseDAAPIComponent
   {
       
      
      private var _sessionBattleStatsViewVO:SessionBattleStatsViewVO;
      
      public function SessionBattleStatsViewMeta()
      {
