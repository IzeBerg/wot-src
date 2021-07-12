package net.wg.gui.lobby.clans.profile.views
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.CLANS_ALIASES;
   import net.wg.gui.components.assets.SeparatorAsset;
   import net.wg.gui.components.assets.data.SeparatorConstants;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.components.containers.IGroupEx;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileGlobalMapInfoVO;
   import net.wg.gui.lobby.components.StatisticsBodyContainer;
   import net.wg.infrastructure.base.meta.IClanProfileGlobalMapInfoViewMeta;
   import net.wg.infrastructure.base.meta.impl.ClanProfileGlobalMapInfoViewMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import scaleform.clik.constants.InvalidationType;
   
   public class ClanProfileGlobalMapInfoView extends ClanProfileGlobalMapInfoViewMeta implements IClanProfileGlobalMapInfoViewMeta
   {
      
      private static const BOTTOM_GAP:int = 48;
      
      private static const STATS_GAP:int = 45;
       
      
      public var group:IGroupEx = null;
      
      public var body:StatisticsBodyContainer = null;
      
      public var separator:SeparatorAsset = null;
      
      public var separatorBottom:SeparatorAsset = null;
      
      public var primeTimeText:TextField = null;
      
      private var _data:ClanProfileGlobalMapInfoVO = null;
      
      public function ClanProfileGlobalMapInfoView()
      {
         super();
      }
      
      override protected function setData(param1:ClanProfileGlobalMapInfoVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.primeTimeText.autoSize = TextFieldAutoSize.CENTER;
         var _loc1_:HorizontalGroupLayout = new HorizontalGroupLayout();
         _loc1_.gap = STATS_GAP;
         this.group.layout = _loc1_;
         this.group.itemRendererLinkage = Linkages.ADVANCED_LINE_DESCR_ICON_TEXT_UI;
         var _loc2_:Number = height - this.body.y - this.body.viewStackStartYPosition - BOTTOM_GAP >> 0;
         this.body.setAvailableSize(width,_loc2_);
         this.body.viewStack.addEventListener(ViewStackEvent.NEED_UPDATE,this.onBodyViewStackNeedUpdateHandler);
         this.separator.setType(SeparatorConstants.DOTTED_TYPE);
         this.separator.setMode(SeparatorConstants.TILE_MODE);
         this.separatorBottom.setType(SeparatorConstants.MEDIUM_TYPE);
      }
      
      override protected function onDispose() : void
      {
         this.body.viewStack.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onBodyViewStackNeedUpdateHandler);
         this.body.dispose();
         this.body = null;
         this.group.dispose();
         this.group = null;
         this.separator.dispose();
         this.separator = null;
         this.separatorBottom.dispose();
         this.separatorBottom = null;
         this.primeTimeText = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.group.dataProvider = this._data.headerParams;
            this.body.setDossierData(this._data.bodyParams);
            this.primeTimeText.htmlText = this._data.primeTimeText;
         }
      }
      
      private function onBodyViewStackNeedUpdateHandler(param1:ViewStackEvent) : void
      {
         if(param1.viewId == CLANS_ALIASES.CLAN_PROFILE_TABLE_STATISTICS_VIEW_LINKAGE)
         {
            registerFlashComponentS(IDAAPIModule(param1.view),CLANS_ALIASES.CLAN_PROFILE_TABLE_STATISTICS_VIEW_ALIAS);
         }
      }
   }
}
