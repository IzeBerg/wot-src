package net.wg.gui.lobby.hangar.ammunitionPanelInject
{
   import flash.utils.Dictionary;
   import net.wg.data.constants.Directions;
   import net.wg.gui.lobby.hangar.ammunitionPanelInject.data.HelpLayoutDataVO;
   import net.wg.gui.lobby.hangar.ammunitionPanelInject.events.AmmunitionPanelInjectEvents;
   import net.wg.infrastructure.base.meta.IAmmunitionPanelInjectMeta;
   import net.wg.infrastructure.base.meta.impl.AmmunitionPanelInjectMeta;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import net.wg.utils.helpLayout.IHelpLayoutComponent;
   
   public class AmmunitionPanelInject extends AmmunitionPanelInjectMeta implements IAmmunitionPanelInjectMeta, IHelpLayoutComponent
   {
      
      private static const HELP_LAYOUT_ID_DELIMITER:String = "_";
       
      
      private var _helpLayoutData:Dictionary;
      
      public function AmmunitionPanelInject()
      {
         this._helpLayoutData = new Dictionary();
         super();
         setManageSize(false);
      }
      
      override protected function onDispose() : void
      {
         this.clearHelpLayout();
         this._helpLayoutData = null;
         super.onDispose();
      }
      
      override protected function setHelpLayout(param1:HelpLayoutDataVO) : void
      {
         var _loc3_:HelpLayoutDataVO = null;
         var _loc2_:String = param1.sectionType;
         if(!LOBBY_HELP.getAmmunitionPanelHelpMsg(_loc2_))
         {
            return;
         }
         _loc3_ = this._helpLayoutData[_loc2_];
         if(_loc3_)
         {
            if(param1.width == 0)
            {
               _loc3_.dispose();
               this._helpLayoutData[_loc2_] = null;
               delete this._helpLayoutData[_loc2_];
            }
            else
            {
               _loc3_.width = param1.width;
               _loc3_.height = param1.height;
               _loc3_.offsetX = param1.offsetX;
               _loc3_.offsetY = param1.offsetY;
            }
         }
         else
         {
            this._helpLayoutData[_loc2_] = param1;
         }
         dispatchEvent(new AmmunitionPanelInjectEvents(AmmunitionPanelInjectEvents.HELP_LAYOUT_CHANGED));
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.utils.helpLayout.registerComponent(this);
      }
      
      public function as_clearHelpLayout() : void
      {
         this.clearHelpLayout();
      }
      
      public function getLayoutProperties() : Vector.<HelpLayoutVO>
      {
         var _loc2_:HelpLayoutDataVO = null;
         var _loc1_:Vector.<HelpLayoutVO> = new Vector.<HelpLayoutVO>();
         for each(_loc2_ in this._helpLayoutData)
         {
            _loc1_.push(this.createHelpLayoutData(_loc2_.offsetX,_loc2_.offsetY,_loc2_.width,_loc2_.height,LOBBY_HELP.getAmmunitionPanelHelpMsg(_loc2_.sectionType),this.generateHelpLayoutId()));
         }
         return _loc1_;
      }
      
      private function generateHelpLayoutId() : String
      {
         return name + HELP_LAYOUT_ID_DELIMITER + Math.random();
      }
      
      private function createHelpLayoutData(param1:int, param2:int, param3:int, param4:int, param5:String, param6:String) : HelpLayoutVO
      {
         var _loc7_:HelpLayoutVO = new HelpLayoutVO();
         _loc7_.x = param1;
         _loc7_.y = param2;
         _loc7_.width = param3;
         _loc7_.height = param4;
         _loc7_.extensibilityDirection = Directions.RIGHT;
         _loc7_.message = param5;
         _loc7_.id = param6;
         _loc7_.scope = this;
         return _loc7_;
      }
      
      private function clearHelpLayout() : void
      {
         var _loc1_:HelpLayoutDataVO = null;
         for each(_loc1_ in this._helpLayoutData)
         {
            _loc1_.dispose();
         }
         App.utils.data.cleanupDynamicObject(this._helpLayoutData);
      }
   }
}
