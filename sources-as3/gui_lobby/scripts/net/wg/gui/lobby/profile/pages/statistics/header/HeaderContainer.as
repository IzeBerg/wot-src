package net.wg.gui.lobby.profile.pages.statistics.header
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.components.containers.IGroupEx;
   import net.wg.gui.components.icons.BattleTypeIcon;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class HeaderContainer extends UIComponentEx implements IDisposable
   {
      
      private static const GAP:int = -7;
      
      private static const GROUP_OFFSET1:int = 220;
      
      private static const GROUP_OFFSET2:int = 177;
      
      private static const GROUP_OFFSET3:int = 263;
      
      private static const GROUP_OFFSET_DEFAULT:int = 133;
      
      private static const OFFSET1_GROUP_COUNT:int = 4;
      
      private static const OFFSET2_GROUP_COUNT:int = 5;
      
      private static const OFFSET3_GROUP_COUNT:int = 3;
       
      
      public var icon:BattleTypeIcon = null;
      
      public var group:IGroupEx = null;
      
      public var image:HeaderBGImage = null;
      
      private var _itemsData:DataProvider = null;
      
      public function HeaderContainer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.group.dispose();
         this.group = null;
         this.image.dispose();
         this.image = null;
         this.clearData();
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:HorizontalGroupLayout = new HorizontalGroupLayout();
         _loc1_.gap = GAP;
         this.group.layout = _loc1_;
         this.group.itemRendererLinkage = Linkages.ADVANCED_LINE_DESCR_ICON_TEXT_UI;
      }
      
      public function battlesType(param1:String, param2:String) : void
      {
         this.image.gotoAndStop(param1);
         this.icon.type = param2;
      }
      
      public function setDossierData(param1:Array) : void
      {
         this.clearData();
         this._itemsData = new DataProvider();
         var _loc2_:uint = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._itemsData.push(new StatisticsHeaderVO(param1[_loc3_]));
            _loc3_++;
         }
         this.group.dataProvider = this._itemsData;
         switch(_loc2_)
         {
            case OFFSET1_GROUP_COUNT:
               this.group.x = GROUP_OFFSET1;
               break;
            case OFFSET2_GROUP_COUNT:
               this.group.x = GROUP_OFFSET2;
               break;
            case OFFSET3_GROUP_COUNT:
               this.group.x = GROUP_OFFSET3;
               break;
            default:
               this.group.x = GROUP_OFFSET_DEFAULT;
         }
         App.toolTipMgr.hide();
      }
      
      private function clearData() : void
      {
         var _loc1_:IDisposable = null;
         if(this._itemsData)
         {
            for each(_loc1_ in this._itemsData)
            {
               _loc1_.dispose();
            }
            this._itemsData.cleanUp();
            this._itemsData = null;
         }
      }
   }
}
