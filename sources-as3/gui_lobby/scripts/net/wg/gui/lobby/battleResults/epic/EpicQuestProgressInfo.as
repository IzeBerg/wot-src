package net.wg.gui.lobby.battleResults.epic
{
   import net.wg.gui.components.controls.TileList;
   import net.wg.gui.lobby.battleResults.epic.vo.EpicQuestProgressInfoItemVO;
   import net.wg.infrastructure.base.meta.IEpicQuestProgressInfoMeta;
   import net.wg.infrastructure.base.meta.impl.EpicQuestProgressInfoMeta;
   import scaleform.clik.data.DataProvider;
   
   public class EpicQuestProgressInfo extends EpicQuestProgressInfoMeta implements IEpicQuestProgressInfoMeta
   {
       
      
      public var tileList:TileList = null;
      
      public function EpicQuestProgressInfo()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.tileList.dispose();
         this.tileList = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function updateData(param1:Vector.<EpicQuestProgressInfoItemVO>) : void
      {
         this.tileList.dataProvider = new DataProvider(App.utils.data.vectorToArray(param1));
      }
   }
}
