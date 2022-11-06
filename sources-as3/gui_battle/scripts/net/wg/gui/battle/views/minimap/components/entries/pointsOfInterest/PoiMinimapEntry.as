package net.wg.gui.battle.views.minimap.components.entries.pointsOfInterest
{
   import net.wg.data.constants.generated.POI_CONSTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   
   public class PoiMinimapEntry extends BattleUIComponent
   {
      
      private static const DIVIDE_100:Number = 0.01;
       
      
      public var marker:MinimapPoiProgressCircle = null;
      
      private var _statusId:int = 0;
      
      public function PoiMinimapEntry()
      {
         super();
         this.marker.visible = true;
         MinimapEntryController.instance.registerScalableEntry(this);
      }
      
      override protected function onDispose() : void
      {
         MinimapEntryController.instance.unregisterScalableEntry(this);
         this.marker.dispose();
         this.marker = null;
         super.onDispose();
      }
      
      public function setIsAlly(param1:Boolean) : void
      {
         this.marker.setIsAlly(param1);
      }
      
      public function setProgress(param1:int) : void
      {
         if(this._statusId == POI_CONSTS.POI_STATUS_ACTIVE)
         {
            return;
         }
         this.marker.updateProgress(param1 * DIVIDE_100);
      }
      
      public function setStatus(param1:int) : void
      {
         if(this._statusId != param1)
         {
            this._statusId = param1;
            this.marker.setStatusID(param1);
         }
      }
      
      public function setType(param1:int) : void
      {
         this.marker.setIconType(param1);
      }
   }
}
