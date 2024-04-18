package net.wg.gui.components.controls.tabs
{
   import net.wg.gui.components.advanced.ButtonBarEx;
   import scaleform.clik.controls.Button;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class OrangeTabMenu extends ButtonBarEx
   {
      
      private static const INV_TABS_SOUND_TYPE:String = "invTabsSoundType";
       
      
      private var _firstTimeSelection:Boolean;
      
      private var _tabsSoundType:String = "storageTab";
      
      public function OrangeTabMenu()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.draw();
         if(isInvalid(INV_TABS_SOUND_TYPE))
         {
            _loc1_ = _renderers.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               OrangeTabButton(_renderers[_loc2_]).soundType = this._tabsSoundType;
               _loc2_++;
            }
         }
      }
      
      override protected function rescaleContainer() : void
      {
      }
      
      override protected function setupRenderer(param1:Button, param2:uint) : void
      {
         super.setupRenderer(param1,param2);
         OrangeTabButton(param1).isLastRenderer = param2 == _dataProvider.length - 1;
      }
      
      override protected function populateRendererData(param1:Button, param2:uint) : void
      {
         var _loc3_:OrangeTabsMenuVO = OrangeTabsMenuVO(_dataProvider.requestItemAt(param2));
         if(_loc3_.selected && this._firstTimeSelection)
         {
            selectedIndex = param2;
            this._firstTimeSelection = false;
         }
         super.populateRendererData(param1,param2);
      }
      
      public function getWidth() : int
      {
         var _loc1_:Button = null;
         if(_renderers && _renderers.length)
         {
            _loc1_ = _renderers[_renderers.length - 1];
            return _loc1_.x + _loc1_.width;
         }
         return 0;
      }
      
      override public function set dataProvider(param1:IDataProvider) : void
      {
         this._firstTimeSelection = true;
         super.dataProvider = param1;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(visible == param1)
         {
            return;
         }
         super.visible = param1;
         var _loc2_:int = _renderers.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _renderers[_loc3_].visible = param1;
            _loc3_++;
         }
      }
      
      public function set tabsSoundType(param1:String) : void
      {
         if(this._tabsSoundType != param1)
         {
            this._tabsSoundType = param1;
            invalidate(INV_TABS_SOUND_TYPE);
         }
      }
   }
}
