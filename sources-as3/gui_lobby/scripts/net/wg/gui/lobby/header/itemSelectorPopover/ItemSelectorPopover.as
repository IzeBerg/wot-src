package net.wg.gui.lobby.header.itemSelectorPopover
{
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.events.ItemSelectorRendererEvent;
   import net.wg.gui.components.miniclient.BattleTypeMiniClientComponent;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.lobby.header.events.BattleTypeSelectorEvent;
   import net.wg.infrastructure.base.meta.IBattleTypeSelectPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.BattleTypeSelectPopoverMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class ItemSelectorPopover extends BattleTypeSelectPopoverMeta implements IBattleTypeSelectPopoverMeta
   {
      
      private static const LIPS_PADDING:int = 10;
      
      private static const LIST_TOP_PADDING:int = -8;
      
      private static const LIST_LEFT_PADDING:int = -6;
      
      private static const LIST_RIGHT_PADDING:int = -6;
      
      private static const LINK_GAP:int = 2;
       
      
      public var list:ItemSelectorList = null;
      
      public var listExtra:ItemSelectorList = null;
      
      public var topLip:MovieClip = null;
      
      public var bottomLip:MovieClip = null;
      
      private var _isShowDemonstrator:Boolean = false;
      
      private var _demonstrationItem:BattleTypeSelectPopoverDemonstrator = null;
      
      private var _items:DataProvider = null;
      
      private var _extraItems:DataProvider = null;
      
      private var _hitSprite:Sprite;
      
      private var _miniClientComponent:BattleTypeMiniClientComponent = null;
      
      public function ItemSelectorPopover()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.topLip.mouseChildren = this.bottomLip.mouseChildren = false;
         this.topLip.mouseEnabled = this.bottomLip.mouseEnabled = false;
         this.list.y = LIST_TOP_PADDING + LIPS_PADDING;
         this.list.x = this.listExtra.x = LIST_LEFT_PADDING;
         this._hitSprite = new Sprite();
         addChildAt(this._hitSprite,getChildIndex(this.listExtra));
         hitArea = this._hitSprite;
         if(!hasEventListener(ListEvent.INDEX_CHANGE))
         {
            addEventListener(ItemSelectorRendererEvent.RENDERER_CLICK,this.onRendererClickHandler,false,0,true);
            addEventListener(ItemSelectorRendererEvent.RENDERER_OVER,this.onRendererOverHandler,false,0,true);
         }
      }
      
      override protected function initLayout() : void
      {
         popoverLayout.preferredLayout = PopOverConst.ARROW_TOP;
         super.initLayout();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Graphics = null;
         if(_baseDisposed)
         {
            return;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._demonstrationItem != null)
            {
               this._demonstrationItem.visible = this._isShowDemonstrator;
            }
            if(this._items != null)
            {
               this.list.y = !!this._isShowDemonstrator ? Number(this._demonstrationItem.y + this._demonstrationItem.height + LIST_TOP_PADDING ^ 0) : Number(LIPS_PADDING + LIST_TOP_PADDING);
               this.list.rowCount = this._items.length;
               this.list.dataProvider = this._items;
            }
            if(this._extraItems != null)
            {
               this.listExtra.y = this.list.y + this.list.height;
               this.listExtra.rowCount = this._extraItems.length;
               this.listExtra.dataProvider = this._extraItems;
            }
            this.updateSelectedItem();
            this.list.validateNow();
            this.listExtra.validateNow();
            this.topLip.y = !!this._isShowDemonstrator ? Number(this._demonstrationItem.y - this.topLip.height ^ 0) : Number(this.list.y - this.topLip.height - LIST_TOP_PADDING ^ 0);
            this.bottomLip.y = this.list.y + this.list.height + this.listExtra.height + this.bottomLip.height - LIST_TOP_PADDING ^ 0;
            _loc1_ = this.list.width + LIST_RIGHT_PADDING + LIST_LEFT_PADDING;
            _loc2_ = this.list.y + this.list._gap + this.list.height + this.listExtra.height + LIST_TOP_PADDING + LIPS_PADDING;
            _loc3_ = this._hitSprite.graphics;
            _loc3_.clear();
            _loc3_.beginFill(0,0);
            _loc3_.drawRect(0,0,_loc1_,_loc2_);
            _loc3_.endFill();
            setSize(this._hitSprite.width,this._hitSprite.height);
         }
         if(this._miniClientComponent != null)
         {
            this.updateSizeMiniClientInfo();
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(ItemSelectorRendererEvent.RENDERER_CLICK,this.onRendererClickHandler);
         removeEventListener(ItemSelectorRendererEvent.RENDERER_OVER,this.onRendererOverHandler);
         if(this._demonstrationItem != null)
         {
            this._demonstrationItem.removeEventListener(BattleTypeSelectorEvent.BATTLE_TYPE_ITEM_EVENT,this.onDemonstrationItemBattleTypeItemEventHandler);
            this._demonstrationItem.dispose();
            this._demonstrationItem = null;
         }
         this.listExtra.dispose();
         this.listExtra = null;
         this.list.dispose();
         this.list = null;
         this.topLip = null;
         this.bottomLip = null;
         hitArea = null;
         this._hitSprite = null;
         this._items = null;
         this._extraItems = null;
         this._miniClientComponent = null;
         super.onDispose();
      }
      
      override protected function update(param1:DataProvider, param2:DataProvider, param3:Boolean, param4:Boolean) : void
      {
         this._items = param1;
         this._extraItems = param2;
         this._isShowDemonstrator = param3;
         if(this._isShowDemonstrator)
         {
            this.createDemonstrator();
            this._demonstrationItem.enabled = param4;
         }
         invalidateData();
      }
      
      public function as_showMiniClientInfo(param1:String, param2:String) : void
      {
         this._miniClientComponent = App.utils.classFactory.getComponent(Linkages.BATTLE_TYPES_MINI_CLIENT_COMPONENT,BattleTypeMiniClientComponent);
         this._miniClientComponent.gap = LINK_GAP;
         this._miniClientComponent.autoAlignVerticalCenter = true;
         this._miniClientComponent.autoAlignHorizontalCenter = true;
         this._miniClientComponent.update(param1,param2);
         addChild(this._miniClientComponent);
         registerFlashComponentS(this._miniClientComponent,Aliases.MINI_CLIENT_LINKED);
         if(this.list.rowCount > 0)
         {
            this.updateSizeMiniClientInfo();
         }
      }
      
      private function createDemonstrator() : void
      {
         if(this._demonstrationItem == null)
         {
            this._demonstrationItem = App.utils.classFactory.getComponent(Aliases.ITEM_SELECTOR_DEMONSTRATOR,BattleTypeSelectPopoverDemonstrator);
            addChild(this._demonstrationItem);
            this._demonstrationItem.addEventListener(BattleTypeSelectorEvent.BATTLE_TYPE_ITEM_EVENT,this.onDemonstrationItemBattleTypeItemEventHandler);
            this._demonstrationItem.y = LIPS_PADDING;
         }
      }
      
      private function updateSizeMiniClientInfo() : void
      {
         var _loc5_:IListItemRenderer = null;
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:int = this.list.rowCount;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this.list.getRendererAt(_loc4_);
            if(!_loc5_.enabled)
            {
               _loc1_ += this.list.rowHeight;
               if(!_loc2_)
               {
                  this._miniClientComponent.y = _loc5_.y + (this.list._gap >> 1) + LIST_TOP_PADDING + LIPS_PADDING;
                  _loc2_ = true;
               }
            }
            _loc4_++;
         }
         this._miniClientComponent.height = _loc1_;
         this._miniClientComponent.width = width;
      }
      
      private function updateSelectedItem() : void
      {
         var _loc1_:ItemSelectorList = this.listExtra.selectedIndex == -1 ? this.list : this.listExtra;
         if(_loc1_.selectedIndex == -1)
         {
            _loc1_.selectedIndex = _loc1_.getFirstSelectablePosition(0,true);
         }
         else if(_loc1_.selectedIndex < _loc1_.getFirstSelectablePosition(_loc1_.dataProvider.length - 1,false))
         {
            _loc1_.selectedIndex = _loc1_.getFirstSelectablePosition(_loc1_.selectedIndex,true);
         }
         else
         {
            _loc1_.selectedIndex = _loc1_.getFirstSelectablePosition(0,true);
         }
      }
      
      private function onRendererOverHandler(param1:ItemSelectorRendererEvent) : void
      {
         var _loc4_:ItemSelectorTooltipDataVO = null;
         var _loc2_:String = param1.itemData;
         var _loc3_:Object = getTooltipDataS(_loc2_,param1.itemIsDisabled);
         if(_loc3_)
         {
            _loc4_ = new ItemSelectorTooltipDataVO(_loc3_);
            if(_loc4_.isWulf)
            {
               App.toolTipMgr.showWulfTooltip(_loc4_.tooltip,null);
            }
            else if(_loc4_.isSpecial)
            {
               App.toolTipMgr.showSpecial(_loc4_.tooltip,null);
            }
            else
            {
               App.toolTipMgr.showComplex(_loc4_.tooltip);
            }
         }
      }
      
      private function onRendererClickHandler(param1:ItemSelectorRendererEvent) : void
      {
         param1.stopImmediatePropagation();
         selectFightS(ItemSelectorRendererVO(param1.target.data).data);
         App.popoverMgr.hide();
      }
      
      private function onDemonstrationItemBattleTypeItemEventHandler(param1:BattleTypeSelectorEvent) : void
      {
         demoClickS();
      }
   }
}
