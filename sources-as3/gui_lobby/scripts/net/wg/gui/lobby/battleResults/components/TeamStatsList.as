package net.wg.gui.lobby.battleResults.components
{
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.constants.WrappingMode;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.ui.InputDetails;
   
   public class TeamStatsList extends ScrollingListEx
   {
       
      
      private var _commonStatsVO:CommonStatsVO = null;
      
      public function TeamStatsList()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this._commonStatsVO = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         wrapping = WrappingMode.NORMAL;
      }
      
      override protected function drawLayout() : void
      {
         var _loc8_:IListItemRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:Number = rowHeight ^ 0;
         var _loc3_:Number = availableWidth - padding.horizontal;
         var _loc4_:Number = margin + padding.left ^ 0;
         var _loc5_:Number = margin + padding.top ^ 0;
         var _loc6_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc1_)
         {
            _loc8_ = getRendererAt(_loc7_);
            _loc8_.x = _loc4_;
            _loc8_.y = _loc5_ + _loc7_ * _loc2_;
            _loc8_.width = _loc3_;
            if(!_loc6_)
            {
               _loc8_.validateNow();
            }
            _loc7_++;
         }
         drawScrollBar();
      }
      
      override protected function externalSetupRenderer(param1:IListItemRenderer) : void
      {
         var _loc2_:TeamMemberRendererBase = TeamMemberRendererBase(param1);
         _loc2_.setCommonStatsVO(this._commonStatsVO);
         super.externalSetupRenderer(param1);
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
                     return;
                  }
               }
               else if(_selectedIndex > 0)
               {
                  if(_loc4_)
                  {
                     --selectedIndex;
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
                     selectedIndex = _dataProvider.length - 1;
                  }
               }
               break;
            case NavigationCode.DOWN:
               if(_selectedIndex == -1)
               {
                  if(_loc4_)
                  {
                     selectedIndex = _scrollPosition;
                  }
               }
               else if(_selectedIndex < _dataProvider.length - 1)
               {
                  if(_loc4_)
                  {
                     ++selectedIndex;
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
                     selectedIndex = 0;
                  }
               }
               break;
            case NavigationCode.END:
               if(!_loc4_)
               {
                  selectedIndex = _dataProvider.length - 1;
               }
               break;
            case NavigationCode.HOME:
               if(!_loc4_)
               {
                  selectedIndex = 0;
               }
               break;
            case NavigationCode.PAGE_UP:
               if(_loc4_)
               {
                  selectedIndex = Math.max(0,_selectedIndex - _totalRenderers);
               }
               break;
            case NavigationCode.PAGE_DOWN:
               if(_loc4_)
               {
                  selectedIndex = Math.min(_dataProvider.length - 1,_selectedIndex + _totalRenderers);
               }
               break;
            default:
               return;
         }
         param1.handled = true;
      }
      
      override protected function handleItemClick(param1:ButtonEvent) : void
      {
         var _loc2_:Number = IListItemRenderer(param1.currentTarget).index;
         if(isNaN(_loc2_))
         {
            return;
         }
         if(dispatchItemEvent(param1))
         {
            callLogEvent(param1,_loc2_);
            if(useRightButton && useRightButtonForSelect || param1.buttonIdx == 0)
            {
               selectedIndex = _loc2_;
            }
         }
      }
      
      public function setCommonStatsVO(param1:CommonStatsVO) : void
      {
         this._commonStatsVO = param1;
      }
   }
}
