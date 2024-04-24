package net.wg.gui.lobby.header.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.header.headerButtonBar.HeaderButton;
   
   public class HeaderButtonVo extends DAAPIDataClass
   {
       
      
      public var helpText:String = "";
      
      public var helpDirection:String = "";
      
      private var _linkage:String = "";
      
      private var _upperLinkage:String = "";
      
      private var _data:IHBC_VO = null;
      
      private var _id:String = "";
      
      private var _direction:String = "";
      
      private var _align:String = "";
      
      private var _resizePriority:int = -1;
      
      private var _headerButton:HeaderButton = null;
      
      private var _enabled:Boolean = false;
      
      private var _softDisable:Boolean = false;
      
      public function HeaderButtonVo(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this.helpText = null;
         if(this._data != null)
         {
            this._data.dispose();
            App.utils.data.cleanupDynamicObject(this._data);
            this._data = null;
         }
         this.helpDirection = null;
         this._linkage = null;
         this._upperLinkage = null;
         this._id = null;
         this._direction = null;
         this._align = null;
         this._headerButton = null;
         super.onDispose();
      }
      
      public function get linkage() : String
      {
         return this._linkage;
      }
      
      public function set linkage(param1:String) : void
      {
         this._linkage = param1;
      }
      
      public function get data() : IHBC_VO
      {
         return this._data;
      }
      
      public function set data(param1:IHBC_VO) : void
      {
         this._data = param1;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function get direction() : String
      {
         return this._direction;
      }
      
      public function set direction(param1:String) : void
      {
         this._direction = param1;
      }
      
      public function get align() : String
      {
         return this._align;
      }
      
      public function set align(param1:String) : void
      {
         this._align = param1;
      }
      
      public function get headerButton() : HeaderButton
      {
         return this._headerButton;
      }
      
      public function set headerButton(param1:HeaderButton) : void
      {
         this._headerButton = param1;
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this._enabled = param1;
      }
      
      public function get resizePriority() : int
      {
         return this._resizePriority;
      }
      
      public function set resizePriority(param1:int) : void
      {
         this._resizePriority = param1;
      }
      
      public function get upperLinkage() : String
      {
         return this._upperLinkage;
      }
      
      public function set upperLinkage(param1:String) : void
      {
         this._upperLinkage = param1;
      }
      
      public function get softDisable() : Boolean
      {
         return this._softDisable;
      }
      
      public function set softDisable(param1:Boolean) : void
      {
         this._softDisable = param1;
      }
   }
}
