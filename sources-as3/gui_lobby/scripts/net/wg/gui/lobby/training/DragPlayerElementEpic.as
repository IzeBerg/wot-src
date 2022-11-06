package net.wg.gui.lobby.training
{
   import net.wg.data.VO.TrainingRoomRendererVO;
   import net.wg.gui.components.controls.UILoaderAlt;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class DragPlayerElementEpic extends DragPlayerElementBase
   {
       
      
      public var statusIco:UILoaderAlt = null;
      
      public function DragPlayerElementEpic()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.statusIco.dispose();
         this.statusIco = null;
         super.onDispose();
      }
      
      override protected function doUpdateData(param1:TrainingRoomRendererVO) : void
      {
         super.doUpdateData(param1);
         if(StringUtils.isNotEmpty(param1.stateString))
         {
            this.statusIco.visible = true;
            this.statusIco.source = RES_ICONS.MAPS_ICONS_LIBRARY_CANCELICON_1;
         }
         else
         {
            this.statusIco.visible = false;
         }
      }
      
      override protected function doResetData() : void
      {
         super.doResetData();
         this.statusIco.unload();
         this.statusIco.visible = false;
      }
   }
}
