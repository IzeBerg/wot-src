package net.wg.gui.lobby.demonstration
{
   import flash.text.TextField;
   import net.wg.gui.components.minimap.MinimapPresentation;
   import net.wg.gui.lobby.demonstration.data.MapItemVO;
   import net.wg.gui.lobby.demonstration.data.MapPointVO;
   import scaleform.clik.controls.ListItemRenderer;
   
   public class MapItemRenderer extends ListItemRenderer
   {
      
      private static const INVALIDATE_DATA_SETUP:String = "dataSetup";
       
      
      public var minimap:MinimapPresentation;
      
      public var warningLabel:TextField;
      
      public var title:TextField;
      
      public function MapItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         invalidate(INVALIDATE_DATA_SETUP);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         preventAutosizing = true;
         this.minimap.border.visible = false;
         this.warningLabel.text = MENU.DEMONSTRATOR_MAP_DISABLED;
      }
      
      override protected function onDispose() : void
      {
         this.minimap.dispose();
         this.minimap = null;
         this.warningLabel = null;
         this.title = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(data && isInvalid(INVALIDATE_DATA_SETUP))
         {
            this.validateData();
         }
      }
      
      private function validateData() : void
      {
         var _loc2_:MapPointVO = null;
         var _loc1_:MapItemVO = MapItemVO(data);
         this.title.text = _loc1_.name;
         this.minimap.as_changeMap(_loc1_.icon);
         this.minimap.as_clear();
         this.warningLabel.visible = !_loc1_.enabled;
         for each(_loc2_ in _loc1_.points)
         {
            this.minimap.as_addPoint(_loc2_.posX,_loc2_.posY,_loc2_.pointType,_loc2_.color,_loc2_.id.toString());
         }
      }
   }
}
