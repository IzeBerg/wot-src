package net.wg.gui.lobby.sessionStats
{
   import flash.text.TextField;
   import net.wg.gui.components.tooltips.inblocks.blocks.BaseTooltipBlock;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsTankStatusVO;
   
   public class SessionStatsStatusBlock extends BaseTooltipBlock
   {
       
      
      public var statsTf:TextField = null;
      
      public function SessionStatsStatusBlock()
      {
         super();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         var _loc2_:SessionStatsTankStatusVO = new SessionStatsTankStatusVO(param1);
         this.statsTf.htmlText = _loc2_.status;
         _loc2_.dispose();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
      }
   }
}
