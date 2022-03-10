package net.wg.infrastructure.managers.utils.impl
{
   import flash.utils.Dictionary;
   import net.wg.data.daapi.ViewRestrictionVO;
   import net.wg.utils.IViewRestrictions;
   
   public class ViewRestrictions implements IViewRestrictions
   {
       
      
      private var _elementsRestrictions:Dictionary = null;
      
      private var _topOffset:int = 0;
      
      private var _bottomOffset:int = 0;
      
      private var _leftOffset:int = 0;
      
      private var _rightOffset:int = 0;
      
      private var _horizontalOffset:int = 0;
      
      private var _verticalOffset:int = 0;
      
      private var _disposed:Boolean = false;
      
      public function ViewRestrictions()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         App.utils.data.cleanupDynamicObject(this._elementsRestrictions);
         this._elementsRestrictions = null;
      }
      
      public function updateRestrictions(param1:String, param2:ViewRestrictionVO) : void
      {
         if(!this._elementsRestrictions && param2)
         {
            this._elementsRestrictions = new Dictionary();
         }
         this._elementsRestrictions[param1] = param2;
         this.recalculateRestrictions();
      }
      
      private function recalculateRestrictions() : void
      {
         var _loc1_:ViewRestrictionVO = null;
         for each(_loc1_ in this._elementsRestrictions)
         {
            switch(_loc1_.layoutType)
            {
               case ViewRestrictionVO.LAYOUT_TYPE_TOP:
                  this._topOffset = Math.max(_loc1_.offset,this._topOffset);
                  break;
               case ViewRestrictionVO.LAYOUT_TYPE_BOTTOM:
                  this._bottomOffset = Math.max(_loc1_.offset,this._bottomOffset);
                  break;
               case ViewRestrictionVO.LAYOUT_TYPE_LEFT:
                  this._leftOffset = Math.max(_loc1_.offset,this._leftOffset);
                  break;
               case ViewRestrictionVO.LAYOUT_TYPE_RIGHT:
                  this._rightOffset = Math.max(_loc1_.offset,this._rightOffset);
                  break;
            }
         }
         this._verticalOffset = this._topOffset + this._bottomOffset;
         this._horizontalOffset = this._rightOffset + this._leftOffset;
      }
      
      public function get topOffset() : int
      {
         return this._topOffset;
      }
      
      public function get bottomOffset() : int
      {
         return this._bottomOffset;
      }
      
      public function get leftOffset() : int
      {
         return this._leftOffset;
      }
      
      public function get rightOffset() : int
      {
         return this._rightOffset;
      }
      
      public function get horizontalOffset() : int
      {
         return this._horizontalOffset;
      }
      
      public function get verticalOffset() : int
      {
         return this._verticalOffset;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
