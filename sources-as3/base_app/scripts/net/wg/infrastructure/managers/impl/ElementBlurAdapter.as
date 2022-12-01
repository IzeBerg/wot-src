package net.wg.infrastructure.managers.impl
{
   import flash.display.DisplayObject;
   import net.wg.data.constants.generated.LAYER_NAMES;
   import net.wg.infrastructure.interfaces.IManagedContainer;
   import net.wg.infrastructure.interfaces.ISimpleManagedContainer;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.managers.IElementBlurAdapter;
   import net.wg.utils.BlurHelper;
   
   public class ElementBlurAdapter implements IElementBlurAdapter
   {
      
      private static const TOPSUBVIEW_LAYER:int = LAYER_NAMES.LAYER_ORDER.indexOf(LAYER_NAMES.TOP_SUB_VIEW);
      
      private static const VIEW_LAYER:int = LAYER_NAMES.LAYER_ORDER.indexOf(LAYER_NAMES.VIEWS);
       
      
      private var _blurHelper:BlurHelper;
      
      private var _bluredElements:Vector.<DisplayObject>;
      
      private var _containers:Vector.<DisplayObject> = null;
      
      private var _disposed:Boolean = false;
      
      public function ElementBlurAdapter()
      {
         super();
      }
      
      public function blurElements(param1:int, param2:int) : void
      {
         var _loc4_:ISimpleManagedContainer = null;
         var _loc5_:ISimpleManagedContainer = null;
         var _loc8_:IManagedContainer = null;
         var _loc9_:int = 0;
         var _loc10_:uint = 0;
         var _loc11_:IView = null;
         var _loc12_:Array = null;
         var _loc13_:ISimpleManagedContainer = null;
         var _loc14_:DisplayObject = null;
         var _loc3_:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
         for each(_loc5_ in this._containers)
         {
            if(_loc5_.layer < param1)
            {
               if(_loc5_.layer != VIEW_LAYER || param1 > TOPSUBVIEW_LAYER)
               {
                  _loc3_.push(_loc5_);
               }
               else
               {
                  _loc8_ = IManagedContainer(_loc5_);
                  _loc9_ = _loc8_.numChildren;
                  _loc10_ = 0;
                  while(_loc10_ < _loc9_)
                  {
                     _loc11_ = _loc8_.getChildAt(_loc10_) as IView;
                     if(_loc11_)
                     {
                        _loc12_ = _loc11_.getSubContainers();
                        for each(_loc13_ in _loc12_)
                        {
                           if(_loc13_.layer < param1)
                           {
                              _loc3_.push(_loc13_);
                           }
                           else
                           {
                              _loc4_ = _loc13_;
                           }
                        }
                     }
                     _loc10_++;
                  }
               }
            }
            else if(_loc5_.layer == param1)
            {
               _loc4_ = _loc5_;
            }
         }
         if(this._bluredElements && this._bluredElements.length)
         {
            for each(_loc14_ in this._bluredElements)
            {
               if(_loc3_.indexOf(_loc14_) == -1)
               {
                  _loc14_.filters = null;
               }
            }
         }
         var _loc6_:int = _loc4_.numChildren;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc3_.push(_loc4_.getChildAt(_loc7_));
            _loc7_++;
         }
         this._bluredElements = _loc3_;
         if(this._blurHelper)
         {
            this._blurHelper.dispose();
         }
         this._blurHelper = new BlurHelper(param2);
         this._blurHelper.blurElements(this._bluredElements);
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         if(this._blurHelper)
         {
            this._blurHelper.dispose();
            this._blurHelper = null;
         }
         this.cleanUpBluredElements();
         this._containers = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function unblurElements() : void
      {
         if(this._blurHelper)
         {
            this._blurHelper.unblurElements(this._bluredElements);
         }
      }
      
      private function cleanUpBluredElements() : void
      {
         if(this._bluredElements)
         {
            this._bluredElements.splice(0,this._bluredElements.length);
            this._bluredElements = null;
         }
      }
      
      public function set containers(param1:Vector.<DisplayObject>) : void
      {
         this._containers = param1;
      }
   }
}
