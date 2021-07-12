package net.wg.gui.components.tooltips.inblocks.blocks
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.advanced.vo.ProgressBarAnimVO;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesMetaLevelVO;
   
   public class EpicMetaLevelProgressBlock extends EpicProgressBlock
   {
       
      
      public function EpicMetaLevelProgressBlock()
      {
         super();
      }
      
      override protected function createData(param1:Object) : DAAPIDataClass
      {
         return new EpicBattlesMetaLevelVO(param1);
      }
      
      override public function setBlockWidth(param1:int) : void
      {
      }
      
      override protected function get progressData() : ProgressBarAnimVO
      {
         return EpicBattlesMetaLevelVO(this.data).progressBarData;
      }
   }
}
