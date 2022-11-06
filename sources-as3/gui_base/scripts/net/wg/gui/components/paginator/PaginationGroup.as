package net.wg.gui.components.paginator
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.events.PaginationGroupEvent;
   import scaleform.clik.constants.InvalidationType;
   
   public class PaginationGroup extends GroupEx
   {
       
      
      private var _maxElementsPerPage:int = 0;
      
      private var _currentPageIndex:int = 0;
      
      public function PaginationGroup()
      {
         super();
      }
      
      override public function getProviderLength() : uint
      {
         var _loc1_:uint = super.getProviderLength();
         if(this.isMultiPages())
         {
            _loc1_ -= this._currentPageIndex * this._maxElementsPerPage;
            if(_loc1_ > this._maxElementsPerPage)
            {
               _loc1_ = this._maxElementsPerPage;
            }
         }
         return _loc1_;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            dispatchEvent(new PaginationGroupEvent(PaginationGroupEvent.GROUP_CHANGED));
         }
      }
      
      override protected function getProviderItemAt(param1:int) : Object
      {
         var _loc2_:int = !!this.isMultiPages() ? int(param1 + this._maxElementsPerPage * this._currentPageIndex) : int(param1);
         return super.getProviderItemAt(_loc2_);
      }
      
      public function ensureIndexVisible(param1:int) : void
      {
         if(this.isMultiPages())
         {
            if(this._maxElementsPerPage * this._currentPageIndex < param1 || this._maxElementsPerPage * (this._currentPageIndex + 1) >= param1)
            {
               this.currentPageIndex = param1 / this._maxElementsPerPage;
            }
         }
      }
      
      public function getPagesCount() : uint
      {
         return Math.ceil(this.getProviderRealLength() / this._maxElementsPerPage);
      }
      
      public function getProviderRealLength() : uint
      {
         return super.getProviderLength();
      }
      
      public function getRendererIndex(param1:int) : int
      {
         if(this.isMultiPages())
         {
            param1 %= this._maxElementsPerPage;
         }
         return param1;
      }
      
      public function isMultiPages() : Boolean
      {
         return this._maxElementsPerPage > 0 && this._maxElementsPerPage < this.getProviderRealLength();
      }
      
      override public function get width() : Number
      {
         return !!this.isMultiPages() ? Number(super.width / this.getProviderLength() * this._maxElementsPerPage) : Number(super.width);
      }
      
      public function set maxElementsPerPage(param1:int) : void
      {
         App.utils.asserter.assert(param1 >= 0,Errors.WRONG_VALUE);
         if(this._maxElementsPerPage != param1)
         {
            this._maxElementsPerPage = param1;
            invalidateData();
         }
      }
      
      public function set currentPageIndex(param1:int) : void
      {
         App.utils.asserter.assert(param1 >= 0,Errors.WRONG_VALUE);
         if(this._currentPageIndex != param1)
         {
            this._currentPageIndex = param1;
            dispatchEvent(new PaginationGroupEvent(PaginationGroupEvent.PAGE_CHANGED,this._currentPageIndex));
            invalidateData();
         }
      }
   }
}
