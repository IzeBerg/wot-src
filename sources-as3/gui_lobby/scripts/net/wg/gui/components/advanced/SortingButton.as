package net.wg.gui.components.advanced
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.SortingInfo;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.SortingEvent;
   import net.wg.gui.events.UILoaderEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.TextFieldEx;
   
   public class SortingButton extends ScalableIconButton
   {
      
      private static const ASCENDING_ICON_INVALID:String = "ascIcon";
      
      private static const DESCENDING_ICON_INVALID:String = "descIcon";
      
      private static const SORT_DIRECTION_INVALID:String = "checkSortDirection";
       
      
      public var labelField:TextField;
      
      public var defaultSortDirection:String = "none";
      
      public var bg:MovieClip;
      
      public var upperBg:MovieClip;
      
      public var mcAscendingIcon:UILoaderAlt;
      
      public var mcDescendingIcon:UILoaderAlt;
      
      protected var isSortIconLoadingCompete:Boolean;
      
      private var _ascendingIconSource:String;
      
      private var _descendingIconSource:String;
      
      private var _sortDirection:String;
      
      private var _id:String;
      
      public function SortingButton()
      {
         super();
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:SortingButtonVO = null;
         super.data = param1;
         if(param1 is SortingButtonVO)
         {
            _loc2_ = SortingButtonVO(param1);
            if(!isNaN(_loc2_.buttonWidth))
            {
               width = _loc2_.buttonWidth;
            }
            if(!isNaN(_loc2_.buttonHeight))
            {
               height = _loc2_.buttonHeight;
            }
            if(_loc2_.defaultSortDirection)
            {
               this.defaultSortDirection = _loc2_.defaultSortDirection;
            }
            if(_loc2_.toolTip)
            {
               tooltip = _loc2_.toolTip;
            }
            enabled = _loc2_.enabled;
            mouseEnabledOnDisabled = _loc2_.mouseEnabledOnDisabled;
            this._id = _loc2_.id;
            this.ascendingIconSource = _loc2_.ascendingIconSource;
            this.descendingIconSource = _loc2_.descendingIconSource;
            iconSource = _loc2_.iconSource;
         }
         invalidateData();
      }
      
      [Inspectable(defaultValue="none",name="sortDirection",enumeration="none,ascending,descending")]
      public function get sortDirection() : String
      {
         return this._sortDirection;
      }
      
      public function set sortDirection(param1:String) : void
      {
         var value:String = param1;
         if(value != SortingInfo.ASCENDING_SORT && value != SortingInfo.DESCENDING_SORT && value != SortingInfo.WITHOUT_SORT)
         {
            try
            {
               DebugUtils.LOG_WARNING("Flash :: Unknown sorting button state: ",value);
            }
            catch(e:Error)
            {
            }
            value = SortingInfo.WITHOUT_SORT;
         }
         if(this._sortDirection != value)
         {
            this._sortDirection = value;
            dispatchEvent(new SortingEvent(SortingEvent.SORT_DIRECTION_CHANGED,true));
            invalidate(SORT_DIRECTION_INVALID);
         }
      }
      
      [Inspectable(name="ascendingIconSource",type="String")]
      public function get ascendingIconSource() : String
      {
         return this._ascendingIconSource;
      }
      
      public function set ascendingIconSource(param1:String) : void
      {
         this._ascendingIconSource = param1;
         invalidate(ASCENDING_ICON_INVALID);
      }
      
      [Inspectable(name="descendingIconSource",type="String")]
      public function get descendingIconSource() : String
      {
         return this._descendingIconSource;
      }
      
      public function set descendingIconSource(param1:String) : void
      {
         this._descendingIconSource = param1;
         invalidate(DESCENDING_ICON_INVALID);
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      override protected function onDispose() : void
      {
         this.bg = null;
         this.upperBg = null;
         this.labelField = null;
         this.mcAscendingIcon.removeEventListener(UILoaderEvent.COMPLETE,this.sortingIconLoadingCompleteHandler);
         this.mcAscendingIcon.dispose();
         this.mcAscendingIcon = null;
         this.mcDescendingIcon.dispose();
         this.mcDescendingIcon = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         TextFieldEx.setVerticalAlign(this.labelField,TextFieldAutoSize.CENTER);
         this.tabEnabled = false;
         this.mcAscendingIcon.addEventListener(UILoaderEvent.COMPLETE,this.sortingIconLoadingCompleteHandler);
         this.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.labelField && isInvalid(InvalidationType.DATA))
         {
            if(!iconSource && data && data.label)
            {
               this.labelField.visible = true;
               this.labelField.text = data.label;
            }
            else
            {
               this.labelField.visible = false;
            }
         }
         if(isInvalid(ASCENDING_ICON_INVALID))
         {
            this.mcAscendingIcon.source = this._ascendingIconSource;
         }
         if(isInvalid(DESCENDING_ICON_INVALID))
         {
            this.mcDescendingIcon.source = this._descendingIconSource;
         }
         if(this.isSortIconLoadingCompete)
         {
            this.isSortIconLoadingCompete = false;
            this.visible = true;
            invalidate(SORT_DIRECTION_INVALID,InvalidationType.SIZE);
            invalidate();
         }
         if(isInvalid(SORT_DIRECTION_INVALID))
         {
            this.applySortDirection();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.bg.width = _width;
            this.bg.height = _height;
            if(this.upperBg)
            {
               this.upperBg.width = _width - 2;
               this.upperBg.height = _height;
            }
            this.updateTextSize();
         }
      }
      
      private function updateTextSize(param1:Boolean = false) : void
      {
         if(param1)
         {
            TextFieldEx.setVerticalAlign(this.labelField,TextFieldAutoSize.CENTER);
         }
         if(this.labelField && this.labelField.visible)
         {
            this.labelField.width = _width;
            this.labelField.height = _height;
         }
      }
      
      override protected function updateAfterStateChange() : void
      {
         super.updateAfterStateChange();
         this.bg.width = _width;
         this.bg.height = _height;
         if(this.upperBg)
         {
            this.upperBg.width = _width - 2;
            this.upperBg.height = _height;
         }
         this.updateTextSize(true);
      }
      
      protected function applySortDirection() : void
      {
         var _loc1_:SortingButtonVO = SortingButtonVO(data);
         var _loc2_:String = this._sortDirection;
         if(_loc1_.inverted && (_loc2_ == SortingInfo.ASCENDING_SORT || _loc2_ == SortingInfo.DESCENDING_SORT))
         {
            _loc2_ = _loc2_ == SortingInfo.ASCENDING_SORT ? SortingInfo.DESCENDING_SORT : SortingInfo.ASCENDING_SORT;
         }
         if(this.mcAscendingIcon)
         {
            this.mcAscendingIcon.visible = _loc2_ == SortingInfo.ASCENDING_SORT;
         }
         if(this.mcDescendingIcon)
         {
            this.mcDescendingIcon.visible = _loc2_ == SortingInfo.DESCENDING_SORT;
         }
      }
      
      protected function sortingIconLoadingCompleteHandler(param1:UILoaderEvent) : void
      {
         this.mcAscendingIcon.y = Math.round(_height - this.mcAscendingIcon.height);
         this.isSortIconLoadingCompete = true;
         invalidate();
      }
   }
}
