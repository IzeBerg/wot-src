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
      
      public function blurElements(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:ISimpleManagedContainer = null;
         var _loc6_:ISimpleManagedContainer = null;
         var _loc9_:IManagedContainer = null;
         var _loc10_:int = 0;
         var _loc11_:uint = 0;
         var _loc12_:IView = null;
         var _loc13_:Array = null;
         var _loc14_:ISimpleManagedContainer = null;
         var _loc15_:DisplayObject = null;
         var _loc4_:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
         for each(_loc6_ in this._containers)
         {
            if(_loc6_.layer < param1)
            {
               if(_loc6_.layer != VIEW_LAYER || param1 > TOPSUBVIEW_LAYER)
               {
                  _loc4_.push(_loc6_);
               }
               else
               {
                  _loc9_ = IManagedContainer(_loc6_);
                  _loc10_ = _loc9_.numChildren;
                  _loc11_ = 0;
                  while(_loc11_ < _loc10_)
                  {
                     _loc12_ = _loc9_.getChildAt(_loc11_) as IView;
                     if(_loc12_)
                     {
                        _loc13_ = _loc12_.getSubContainers();
                        for each(_loc14_ in _loc13_)
                        {
                           if(_loc14_.layer < param1)
                           {
                              _loc4_.push(_loc14_);
                           }
                           else
                           {
                              _loc5_ = _loc14_;
                           }
                        }
                     }
                     _loc11_++;
                  }
               }
            }
            else if(_loc6_.layer == param1)
            {
               _loc5_ = _loc6_;
            }
         }
         if(this._bluredElements && this._bluredElements.length)
         {
            for each(_loc15_ in this._bluredElements)
            {
               if(_loc4_.indexOf(_loc15_) == -1)
               {
                  _loc15_.filters = null;
               }
            }
         }
         var _loc7_:int = _loc5_.numChildren;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            _loc4_.push(_loc5_.getChildAt(_loc8_));
            _loc8_++;
         }
         this._bluredElements = _loc4_;
         if(this._blurHelper)
         {
            this._blurHelper.dispose();
         }
         this._blurHelper = new BlurHelper(param2,param3);
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
