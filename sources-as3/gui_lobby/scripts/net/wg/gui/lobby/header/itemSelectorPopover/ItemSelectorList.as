package net.wg.gui.lobby.header.itemSelectorPopover
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.helpers.ListUtils;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.constants.WrappingMode;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.ui.InputDetails;
   
   public class ItemSelectorList extends ScrollingListEx
   {
       
      
      public function ItemSelectorList()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:Sprite = new Sprite();
         addChild(_loc1_);
         hitArea = _loc1_;
      }
      
      public function getFirstSelectablePosition(param1:int, param2:Boolean = true) : int
      {
         return ListUtils.getFirstSelectablePosition(param1,selectedIndex,_dataProvider,param2);
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:IListItemRenderer = getRendererAt(_selectedIndex,_scrollPosition);
         if(_loc2_ != null)
         {
            _loc2_.handleInput(param1);
            if(param1.handled)
            {
               return;
            }
         }
         var _loc3_:InputDetails = param1.details;
         var _loc4_:Boolean = _loc3_.value == InputValue.KEY_DOWN || _loc3_.value == InputValue.KEY_HOLD;
         switch(_loc3_.navEquivalent)
         {
            case NavigationCode.UP:
               if(selectedIndex == -1)
               {
                  if(_loc4_)
                  {
                     selectedIndex = this.getFirstSelectablePosition(scrollPosition + _totalRenderers - 1,false);
                  }
               }
               else if(_selectedIndex > this.getFirstSelectablePosition(0,true))
               {
                  if(_loc4_)
                  {
                     selectedIndex = this.getFirstSelectablePosition(selectedIndex - 1,false);
                  }
               }
               else if(wrapping != WrappingMode.STICK)
               {
                  if(wrapping != WrappingMode.WRAP)
                  {
                     return;
                  }
                  if(_loc4_)
                  {
                     selectedIndex = this.getFirstSelectablePosition(_dataProvider.length - 1,false);
                  }
               }
               break;
            case NavigationCode.DOWN:
               if(_selectedIndex == -1)
               {
                  if(_loc4_)
                  {
                     selectedIndex = this.getFirstSelectablePosition(_scrollPosition,true);
                  }
               }
               else if(_selectedIndex < this.getFirstSelectablePosition(_dataProvider.length - 1,false))
               {
                  if(_loc4_)
                  {
                     selectedIndex = this.getFirstSelectablePosition(selectedIndex + 1,true);
                  }
               }
               else if(wrapping != WrappingMode.STICK)
               {
                  if(wrapping != WrappingMode.WRAP)
                  {
                     return;
                  }
                  if(_loc4_)
                  {
                     selectedIndex = this.getFirstSelectablePosition(0,true);
                  }
               }
               break;
            case NavigationCode.END:
               if(!_loc4_)
               {
                  selectedIndex = this.getFirstSelectablePosition(_dataProvider.length - 1,false);
               }
               break;
            case NavigationCode.HOME:
               if(!_loc4_)
               {
                  selectedIndex = this.getFirstSelectablePosition(0,true);
               }
               break;
            case NavigationCode.PAGE_UP:
               if(_loc4_)
               {
                  selectedIndex = this.getFirstSelectablePosition(Math.max(0,_selectedIndex - _totalRenderers),true);
               }
               break;
            case NavigationCode.PAGE_DOWN:
               if(_loc4_)
               {
                  selectedIndex = this.getFirstSelectablePosition(Math.min(_dataProvider.length - 1,_selectedIndex + _totalRenderers),false);
               }
               break;
            default:
               return;
         }
         param1.handled = true;
      }
   }
}
