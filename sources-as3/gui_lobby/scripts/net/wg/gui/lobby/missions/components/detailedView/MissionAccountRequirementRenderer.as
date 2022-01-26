package net.wg.gui.lobby.missions.components.detailedView
{
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.lobby.missions.data.MissionAccountRequirementRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class MissionAccountRequirementRenderer extends UIComponentEx implements IListItemRenderer, IUpdatable
   {
      
      private static const BOTTOM_OFFSET:int = 2;
      
      private static const RENDERER_HEIGHT:int = 110;
      
      private static const RENDERER_WIDTH_BIG:int = 80;
      
      private static const RENDERERS_HORIZONTAL_GAP_NORMAL:int = 24;
       
      
      public var icon:IImage;
      
      public var labelTf:TextField;
      
      public var tokensList:SimpleTileList;
      
      private var _owner:UIComponent = null;
      
      private var _index:uint = 0;
      
      private var _vo:MissionAccountRequirementRendererVO;
      
      public function MissionAccountRequirementRenderer()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._vo && isInvalid(InvalidationType.DATA))
         {
            this.icon.source = this._vo.icon;
            this.labelTf.htmlText = this._vo.text;
            App.utils.commons.updateTextFieldSize(this.labelTf);
            if(this._vo.tokens)
            {
               this.tokensList.dataProvider = this._vo.tokens;
               this.tokensList.validateNow();
            }
            this.icon.visible = this._vo.isNeedShowIcon;
         }
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.tokensList.dispose();
         this.tokensList = null;
         this.labelTf = null;
         this._vo = null;
         this._owner = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tokensList.directionMode = DirectionMode.HORIZONTAL;
         this.tokensList.tileHeight = RENDERER_HEIGHT;
         this.tokensList.renderersAlign = SimpleTileList.RENDERERS_ALIGN_CENTER;
         this.tokensList.tileWidth = RENDERER_WIDTH_BIG;
         this.tokensList.horizontalGap = RENDERERS_HORIZONTAL_GAP_NORMAL;
         this.tokensList.itemRenderer = App.utils.classFactory.getClass(Linkages.MARATHON_HEADER_CONDITION_ITEM_RENDERER_UI);
      }
      
      public function getData() : Object
      {
         return this._vo;
      }
      
      public function setData(param1:Object) : void
      {
         if(param1)
         {
            this._vo = MissionAccountRequirementRendererVO(param1);
            invalidateData();
         }
      }
      
      public function setListData(param1:ListData) : void
      {
         this.index = param1.index;
      }
      
      public function update(param1:Object) : void
      {
         this.setData(param1);
      }
      
      override public function get height() : Number
      {
         return (Boolean(this._vo.tokens) ? RENDERER_HEIGHT : this.labelTf.y + this.labelTf.textHeight) + BOTTOM_OFFSET;
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get owner() : UIComponent
      {
         return this._owner;
      }
      
      public function set owner(param1:UIComponent) : void
      {
         this._owner = param1;
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
   }
}
