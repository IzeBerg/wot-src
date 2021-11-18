package net.wg.gui.components.advanced
{
   import net.wg.data.constants.SortingInfo;
   
   public class InteractiveSortingButton extends SortingButton
   {
       
      
      private var _previousSelectedSorDirection:String;
      
      public function InteractiveSortingButton()
      {
         super();
      }
      
      override public function set toggle(param1:Boolean) : void
      {
      }
      
      override public function set sortDirection(param1:String) : void
      {
         if(sortDirection != param1 && selected)
         {
            this._previousSelectedSorDirection = sortDirection;
         }
         super.sortDirection = param1;
      }
      
      override public function set selected(param1:Boolean) : void
      {
         if(selected != param1)
         {
            if(param1 == false)
            {
               this.sortDirection = SortingInfo.WITHOUT_SORT;
            }
            else if(this._previousSelectedSorDirection != SortingInfo.ASCENDING_SORT && this._previousSelectedSorDirection != SortingInfo.DESCENDING_SORT)
            {
               this.sortDirection = defaultSortDirection == SortingInfo.WITHOUT_SORT ? SortingInfo.ASCENDING_SORT : defaultSortDirection;
            }
            else
            {
               this.sortDirection = defaultSortDirection == SortingInfo.WITHOUT_SORT ? this._previousSelectedSorDirection : defaultSortDirection;
            }
         }
         super.selected = param1;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         _toggle = true;
         allowDeselect = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      override protected function handleRelease(param1:uint = 0) : void
      {
         super.handleRelease(param1);
      }
      
      override protected function handleClick(param1:uint = 0) : void
      {
         if(selected)
         {
            if(sortDirection == SortingInfo.ASCENDING_SORT)
            {
               this.sortDirection = SortingInfo.DESCENDING_SORT;
            }
            else if(sortDirection == SortingInfo.DESCENDING_SORT)
            {
               this.sortDirection = SortingInfo.ASCENDING_SORT;
            }
         }
         else
         {
            super.handleClick(param1);
         }
      }
   }
}
